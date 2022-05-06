defmodule HomeInventoryGraphQL.Application.QueryResolvers do
  defp version, do: Application.get_env(:elixir_boilerplate, :version)

  def application(_parent, _args, _resolution) do
    {:ok, %{version: version()}}
  end
end
