# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :guack,
  ecto_repos: [Guack.Repo]

# Configures the endpoint
config :guack, GuackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7FeaXEm66xYwO8z46XZ9AELrwLivrHbeBV0NCN3M7Lqzyo6eYbEBymWiBZZlH5z2",
  render_errors: [view: GuackWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Guack.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
