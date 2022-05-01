import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :home_inventory, HomeInventory.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "home_inventory_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :home_inventory, HomeInventoryWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ucK+X9h9eXEgPtvRb2xcmbx+gwnvmZxT43R7SGB99dYBCcynPxakCFmwlhlPU+ca",
  server: false

# In test we don't send emails.
config :home_inventory, HomeInventory.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
