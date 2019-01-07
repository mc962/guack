use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :guack, GuackWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :guack, Guack.Repo,
  username: "hatsumei",
  password: "hatsu_local",
  database: "guack_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure Guardian
config :guack, Guack.Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  ttl: [30, :days],
  allowed_drift: 2000,
  verify_issuer: true,
  serializer: Guack.Guardian,
  issuer: "guack",
  secret_key: "NYM5I8Xm9DiQnvOgFxikHbWNj1a36ttkOAW/z/77JrgEqNqyJOI9UndTN5MLxurs"
