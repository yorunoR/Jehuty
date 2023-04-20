defmodule Jehuty.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Jehuty.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Jehuty.PubSub},
      # Start Finch
      {Finch, name: Jehuty.Finch}
      # Start a worker by calling: Jehuty.Worker.start_link(arg)
      # {Jehuty.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Jehuty.Supervisor)
  end
end
