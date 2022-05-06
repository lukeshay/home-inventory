import Config

version = Mix.Project.config()[:version]

config :home_inventory,
  ecto_repos: [HomeInventory.Repo],
  version: version

config :phoenix, :json_library, Jason

config :home_inventory, HomeInventoryWeb.Endpoint,
  pubsub_server: HomeInventory.PubSub,
  render_errors: [view: HomeInventoryWeb.ErrorView, accepts: ~w(html json)]

config :home_inventory, HomeInventory.Repo, start_apps_before_migration: [:ssl]

config :home_inventory, Corsica, allow_headers: :all

config :home_inventory, HomeInventory.Gettext, default_locale: "en"

config :home_inventory, HomeInventoryWeb.ContentSecurityPolicy, allow_unsafe_scripts: false

config :esbuild,
  version: "0.14.0",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :sentry,
  root_source_code_path: File.cwd!(),
  release: version

config :logger, backends: [:console, Sentry.LoggerBackend]

config :dart_sass,
  version: "1.43.4",
  default: [
    args: ~w(css/app.scss ../priv/static/assets/app.css),
    cd: Path.expand("../assets", __DIR__)
  ]

# Import environment configuration
import_config "#{Mix.env()}.exs"
