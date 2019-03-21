# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lv,
  ecto_repos: [Lv.Repo]

# Configures the endpoint
config :lv, LvWeb.Endpoint,
  url: [host: "live.amcodev.me"],
  secret_key_base: "NcxlJIGLXHwuoNRdKkwyDtlrgb8DIIidozb7NTY0vJ2IoDGAjRG7yTiPGbgIbosU",
  render_errors: [view: LvWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Lv.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "DHkYMwKJWJsk2zrSTWtPQHf3e99SJOnu"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
