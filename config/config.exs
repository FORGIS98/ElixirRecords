# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixirrecords,
  ecto_repos: [Elixirrecords.Repo]

# Configures the endpoint
config :elixirrecords, ElixirrecordsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IIQ9JAGtzJsTgE4CuTrRBHt2qptidTQv9H8xKtRqGv8yQe0LKwuxhBYuxTbzZmBe",
  render_errors: [view: ElixirrecordsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Elixirrecords.PubSub,
  live_view: [signing_salt: "djSx0HnI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :ethereumex,
  url: "localhost:8545"
