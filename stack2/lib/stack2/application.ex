defmodule Stack2.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, initial_stack) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Stack2.Worker.start_link(arg)
      # {Stack2.Worker, arg},
      {Stack2.Supervisor, initial_stack}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Stack2.Application]
    Supervisor.start_link(children, opts)
  end
end
