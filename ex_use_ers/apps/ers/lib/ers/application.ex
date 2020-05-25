defmodule Ers.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Ers.Worker.start_link(arg)
      # {Ers.Worker, arg}
      worker(Ers.UseGenServer, []),
#      worker(Ers.WorkActor, []),
      supervisor(Ers.UseSupervisor.Supervisor, [[name: Ers.UseSupervisor.Supervisor]]),
      supervisor(Ers.UseSimpleSup.Supervisor, [[name: Ers.UseSimpleSup.Supervisor]])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ers.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
