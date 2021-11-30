defmodule Storage.Store.Mnesia do
  @behaviour Storage.Store

  @table_name :store

  def init() do
    :mnesia.create_schema([node()])
    :mnesia.start()
    :mnesia.create_table(@table_name, attributes: [:key, :value])
  end

  @impl true
  def insert(key, input) do
    write(key, input)
    :ok
  end

  @impl true
  def fetch(key) do
    read(key)
  end

  defp write(key, value) do
    :mnesia.transaction(fn ->
      :mnesia.write({@table_name, key, value})
    end)

    :ok
  end

  defp read(key) do
    :mnesia.transaction(fn ->
      :mnesia.read({@table_name, key})
    end)
    |> case do
      {:atomic, [{_, _, value}]} -> {:ok, value}
      _ -> {:error, :not_found}
    end
  end
end
