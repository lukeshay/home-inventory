defmodule HomeInventoryGraphQL.Router do
  use Plug.Router

  defmodule GraphQL do
    use Plug.Router

    plug(:match)
    plug(:dispatch)

    forward("/",
      to: Absinthe.Plug,
      init_opts: [
        document_providers: {HomeInventoryGraphQL, :document_providers},
        json_codec: Jason,
        schema: HomeInventoryGraphQL.Schema
      ]
    )
  end

  plug(HomeInventoryGraphQL.Plugs.Context)

  plug(:match)
  plug(:dispatch)

  forward("/graphql", to: GraphQL)

  match(_, do: conn)
end