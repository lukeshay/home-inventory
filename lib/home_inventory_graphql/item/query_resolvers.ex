defmodule HomeInventoryGraphQL.Item.QueryResolvers do
  alias HomeInventory.Inventory.Item

  def items(_parent, _args, _resolution) do
    {:ok, Item.list()}
  end
end
