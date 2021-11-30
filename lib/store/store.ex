defmodule Storage.Store do
  alias Storage.Store.{Redis, Mnesia}

  @callback insert(String.t(), String.t()) :: :ok | :error
  @callback fetch(String.t()) :: {:ok, String.t()} | {:error, any()}

  @spec insert(atom(), String.t(), String.t()) :: :ok | :error
  def insert(store, key, input) do
    case store(store) do
      nil ->
        :error

      store ->
        apply(store, :insert, [key, input])
    end
  end

  @spec fetch(atom(), String.t()) :: {:ok, String.t()} | {:error, any()}
  def fetch(store, key) do
    case store(store) do
      nil ->
        :error

      store ->
        apply(store, :fetch, [key])
    end
  end

  defp store(:mnesia), do: Mnesia
  defp store(:redis), do: Redis
  defp store(_), do: nil
end
