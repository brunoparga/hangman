import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :browser_2, Browser2Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "q656dzTUNB7+y5y2L/kv3lDB5Fwz/HAgjQZzRiCVy8Nuq+BrGToWjEVLdGNeQtWa",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
