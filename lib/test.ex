defmodule Storage.Test do
  def test(size \\ 10_000) do
    [:mnesia, :redis]
    |> Enum.map(fn name ->
      Task.async(fn ->
        do_test(name, size)
      end)
    end)
    |> Enum.map(fn task ->
      task |> Task.await(100_000_000)
    end)
  end

  defp do_test(name, size) do
    {time, result} =
      :timer.tc(fn ->
        insert_data(name, size)
        read_data(name, size)
      end)

    %{
      name: name,
      ok: result[:ok] |> Enum.count(),
      errors: result[:errors] |> Enum.count(),
      time_sec: time / 1_000_000
    }
  end

  defp insert_data(store, number) do
    0..number
    |> Enum.map(fn i ->
      Storage.Store.insert(store, key(i), value(i))
    end)
  end

  defp read_data(store, number) do
    Enum.reduce(0..number, %{errors: [], ok: []}, fn i, acc ->
      key = key(i)

      case Storage.Store.fetch(store, key) do
        {:error, _} = error -> Map.put(acc, :errors, acc.errors ++ [{key, error}])
        {:ok, value} -> Map.put(acc, :ok, acc.ok ++ [{key, value}])
      end
    end)
  end

  defp key(i), do: "key:#{i}"
  defp value(i), do: "value:#{i}"
end
