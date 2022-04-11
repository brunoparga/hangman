import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :browser_1, Browser1Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "OFJwhknB9ztp46Kwcm6ZITn1+IRTuCAwSMJl08P2kYCIBoyX2915KtjFv4sqX+/C",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
