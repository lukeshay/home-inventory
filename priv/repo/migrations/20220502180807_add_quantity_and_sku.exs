defmodule HomeInventory.Repo.Migrations.AddQuantity do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add(:quantity, :integer)
      add(:sku, :string)
    end
  end
end
