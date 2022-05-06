defmodule HomeInventoryGraphQL.Application.Types do
  use Absinthe.Schema.Notation

  alias HomeInventoryGraphQL.Application.QueryResolvers

  object :application do
    @desc "The application version"
    field(:version, :string)
  end

  object :application_queries do
    @desc "A list of application information"
    field :application, :application do
      resolve(&QueryResolvers.application/3)
    end
  end
end
