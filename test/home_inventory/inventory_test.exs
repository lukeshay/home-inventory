defmodule HomeInventory.InventoryTest do
  use HomeInventory.DataCase

  alias HomeInventory.Inventory

  describe "locations" do
    alias HomeInventory.Inventory.Location

    import HomeInventory.InventoryFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Inventory.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Inventory.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Location{} = location} = Inventory.create_location(valid_attrs)
      assert location.description == "some description"
      assert location.name == "some name"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Location{} = location} = Inventory.update_location(location, update_attrs)
      assert location.description == "some updated description"
      assert location.name == "some updated name"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_location(location, @invalid_attrs)
      assert location == Inventory.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Inventory.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Inventory.change_location(location)
    end
  end

  describe "items" do
    alias HomeInventory.Inventory.Item

    import HomeInventory.InventoryFixtures

    @invalid_attrs %{name: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Inventory.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Inventory.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Item{} = item} = Inventory.create_item(valid_attrs)
      assert item.name == "some name"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Item{} = item} = Inventory.update_item(item, update_attrs)
      assert item.name == "some updated name"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_item(item, @invalid_attrs)
      assert item == Inventory.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Inventory.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Inventory.change_item(item)
    end
  end
end
