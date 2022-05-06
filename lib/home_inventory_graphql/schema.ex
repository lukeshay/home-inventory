defmodule HomeInventoryGraphQL.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  alias HomeInventory.Repo

  import_types(Absinthe.Type.Custom)
  import_types(HomeInventoryGraphQL.Application.Types)
  import_types(HomeInventoryGraphQL.Item.Types)

  query do
    extends()

    import_fields(:application_queries)
    import_fields(:item_queries)
  end

  # Even if having an empty mutation block is valid and works in Ansinthe, it
  # causes a Javascript error in GraphiQL so uncomment it when you add the
  # first mutation.
  #
  mutation do
    extends()
  end

  def context(context) do
    Map.put(
      context,
      :loader,
      Dataloader.add_source(Dataloader.new(), Repo, Dataloader.Ecto.new(Repo))
    )
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  def middleware(middleware, _, _) do
    [NewRelic.Absinthe.Middleware] ++ middleware
  end
end
