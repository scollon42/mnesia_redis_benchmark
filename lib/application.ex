defmodule Storage.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Storage.Supervisor]
    Storage.Store.Mnesia.init()

    Supervisor.start_link(
      [
        %{
          id: Storage.Redix,
          start: {Redix, :start_link, ["redis://localhost:6379/3", [name: Storage.Redix]]}
        }
      ],
      opts
    )
  end
end
