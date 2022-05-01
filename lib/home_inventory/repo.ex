defmodule HomeInventory.Repo do
  use Ecto.Repo,
    otp_app: :home_inventory,
    adapter: Ecto.Adapters.Postgres
end
