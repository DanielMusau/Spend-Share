defmodule ExpenseSharingApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ExpenseSharingAppWeb.Telemetry,
      # Start the Ecto repository
      ExpenseSharingApp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ExpenseSharingApp.PubSub},
      # Start Finch
      {Finch, name: ExpenseSharingApp.Finch},
      # Start the Endpoint (http/https)
      ExpenseSharingAppWeb.Endpoint
      # Start a worker by calling: ExpenseSharingApp.Worker.start_link(arg)
      # {ExpenseSharingApp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExpenseSharingApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExpenseSharingAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
