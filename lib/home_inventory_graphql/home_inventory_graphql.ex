defmodule HomeInventoryGraphQL do
  def document_providers(_) do
    [Absinthe.Plug.DocumentProvider.Default, HomeInventoryGraphQL.CompiledQueries]
  end
end
