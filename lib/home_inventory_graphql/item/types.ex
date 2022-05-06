defmodule HomeInventoryGraphQL.Item.Types do
  use Absinthe.Schema.Notation

  alias HomeInventoryGraphQL.Item.QueryResolvers

  object :item do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:quantity, non_null(:integer))
    field(:sku, non_null(:string))
  end

  object :item_queries do
    field :items, list_of(:item) do
      resolve(&QueryResolvers.items/3)
    end
  end
end
