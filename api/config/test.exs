import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jehuty_web, JehutyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "OT0XwVpp+XAi3PVvKCWEkS4j6DJbTIRlEDUOOMsSnKV7zOuq4lxV9CyCGPwFbzZz",
  server: false

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jehuty_web, JehutyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "EGmc2wBHRSbrput+7ygemy7FrtCQ7/Tu39o9scpPniDpBeemJlNkSz/rkzC60Iy6",
  server: false

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :jehuty, Jehuty.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "jehuty_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10
