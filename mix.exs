defmodule HomeInventory.MixProject do
  use Mix.Project

  def project do
    [
      app: :home_inventory,
      version: "0.0.1",
      elixir: "~> 1.13",
      erlang: "~> 24.1",
      elixirc_paths: elixirc_paths(Mix.env()),
      test_paths: ["test"],
      test_pattern: "**/*_test.exs",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: releases()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {HomeInventory.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Assets bundling
      {:esbuild, "~> 0.4", runtime: Mix.env() == :dev},

      # HTTP Client
      {:hackney, "~> 1.18"},

      # HTTP server
      {:plug_cowboy, "~> 2.5"},
      {:plug_canonical_host, "~> 2.0"},
      {:corsica, "~> 1.1"},

      # Phoenix
      {:phoenix, "~> 1.6"},
      {:phoenix_html, "~> 3.2"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_live_reload, "~> 1.3", only: :dev},
      {:phoenix_live_view, "~> 0.17.5"},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:jason, "~> 1.2"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},

      # GraphQL
      {:absinthe, "~> 1.7"},
      {:absinthe_plug, "~> 1.5.8"},
      {:absinthe_federation, "~> 0.2.4"},
      {:dataloader, "~> 1.0"},
      {:absinthe_error_payload, "~> 1.1"},

      # Database
      {:ecto_sql, "~> 3.7"},
      {:postgrex, "~> 0.16"},

      # Translations
      {:gettext, "~> 0.19"},

      # Errors
      {:sentry, "~> 8.0"},

      # Monitoring
      {:new_relic_agent, "~> 1.27"},
      {:new_relic_absinthe, "~> 0.0"},

      # Linting
      {:credo, "~> 1.6", only: [:dev, :test], override: true},
      {:credo_envvar, "~> 0.1", only: [:dev, :test], runtime: false},
      {:credo_naming, "~> 2.0", only: [:dev, :test], runtime: false},

      # Security check
      {:sobelow, "~> 0.11", only: [:dev, :test], runtime: true},
      {:mix_audit, "~> 1.0", only: [:dev, :test], runtime: false},

      # Health
      {:plug_checkup, "~> 0.6"},

      # Test factories
      {:ex_machina, "~> 2.7", only: :test},
      {:faker, "~> 0.17", only: :test},
      {:floki, ">= 0.30.0", only: :test},

      # Test coverage
      {:excoveralls, "~> 0.14", only: :test},
      {:dart_sass, "~> 0.3", runtime: Mix.env() == :dev}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["cmd --cd assets npm run deploy --deploy", "sass default --no-source-map --style=compressed", "phx.digest"]
    ]
  end

  defp releases do
    [
      home_inventory: [
        version: {:from_app, :home_inventory},
        applications: [home_inventory: :permanent],
        include_executables_for: [:unix],
        steps: [:assemble, :tar]
      ]
    ]
  end
end
