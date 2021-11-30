defmodule Storage.Redix do
  def set(key, value) do
    Redix.command(Storage.Redix, ["SET", key, value])
  end

  def get(key) do
    Redix.command(Storage.Redix, ["GET", key])
  end
end
