defmodule ExGame.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExGameWeb.Telemetry,
      ExGame.Repo,
      {DNSCluster, query: Application.get_env(:ex_game, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ExGame.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ExGame.Finch},
      # Start a worker by calling: ExGame.Worker.start_link(arg)
      # {ExGame.Worker, arg},
      # Start to serve requests, typically the last entry
      ExGameWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExGame.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExGameWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
