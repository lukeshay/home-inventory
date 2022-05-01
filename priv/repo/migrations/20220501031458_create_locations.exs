defmodule HomeInventory.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :description, :text

      timestamps()
    end
  end
end
