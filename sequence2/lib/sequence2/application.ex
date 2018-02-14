defmodule Sequence2.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Supervisor.Spec.worker(Sequence2.Server, [123])
      # Starts a worker by calling: Sequence2.Worker.start_link(arg)
      {Sequence2.Server, 123},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sequence2.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
