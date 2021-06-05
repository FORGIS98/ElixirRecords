defmodule Elixirrecords.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Elixirrecords.Repo,
      # Start the Telemetry supervisor
      ElixirrecordsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Elixirrecords.PubSub},
      # Start the Endpoint (http/https)
      ElixirrecordsWeb.Endpoint,
      # Start a worker by calling: Elixirrecords.Worker.start_link(arg)
      # {Elixirrecords.Worker, arg}
      {Elixirrecords.Server, "http://localhost:22000"}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Elixirrecords.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirrecordsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
