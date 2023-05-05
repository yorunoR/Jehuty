defmodule JehutyWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      JehutyWeb.Telemetry,
      # Start the Endpoint (http/https)
      JehutyWeb.Endpoint,
      # Start a worker by calling: JehutyWeb.Worker.start_link(arg)
      # {JehutyWeb.Worker, arg}
      {Absinthe.Subscription, JehutyWeb.Endpoint}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JehutyWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JehutyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
