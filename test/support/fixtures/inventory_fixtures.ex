defmodule HomeInventory.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HomeInventory.Inventory` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> HomeInventory.Inventory.create_location()

    location
  end

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> HomeInventory.Inventory.create_item()

    item
  end
end
