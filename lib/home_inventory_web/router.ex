defmodule HomeInventoryWeb.Router do
  use HomeInventoryWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :session
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {HomeInventoryWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug HomeInventoryWeb.ContentSecurityPolicy
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HomeInventoryWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/locations", LocationController
    resources "/items", ItemController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HomeInventoryWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HomeInventoryWeb.Telemetry
    end
  end

  defp session(conn, _opts) do
    opts =
      Plug.Session.init(
        store: :cookie,
        key: Application.get_env(:home_inventory, __MODULE__)[:session_key],
        signing_salt: Application.get_env(:home_inventory, __MODULE__)[:session_signing_salt]
      )

    Plug.Session.call(conn, opts)
  end
end
