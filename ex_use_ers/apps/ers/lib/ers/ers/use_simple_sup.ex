defmodule Ers.UseSimpleSup.Supervisor do
  @moduledoc false

  @name __MODULE__

  use Supervisor

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: @name)
  end

#  def init(arg) do
#    children = [
##      worker(MyWorker, [arg], restart: :temporary)
#    ]
#
#    supervise(children, strategy: :one_for_one)
#  end

  def init(_args) do
    import Supervisor.Spec

#    {m, f, a} = {Ers.SimpleActor, :start_link, []}
    worker_opts = [restart:  :permanent,
      shutdown: 5000,
      function: :start_link]

    children = [worker(Ers.SimpleActor, [], worker_opts)]
    opts     = [strategy:     :simple_one_for_one,
      max_restarts: 5,
      max_seconds:  5]

    supervise(children, opts)
  end

#  Ers.UseSimpleSup.Supervisor.start_actor()
  def start_actor() do
    Supervisor.start_child(Ers.UseSimpleSup.Supervisor, [])
  end

end