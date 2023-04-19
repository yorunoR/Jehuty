import Config

# Configure your database
config :jehuty, Jehuty.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "jehuty_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
