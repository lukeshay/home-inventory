defmodule HomeInventory.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :location_id, references(:locations)

      timestamps()
    end
  end
end
