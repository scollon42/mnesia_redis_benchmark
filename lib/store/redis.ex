defmodule Storage.Store.Redis do
  @behaviour Storage.Store

  @impl true
  def insert(key, input) do
    Storage.Redix.set(key, input)
    :ok
  end

  @impl true
  def fetch(key) do
    Storage.Redix.get(key)
  end
end
