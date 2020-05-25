defmodule Ers.UseSupervisor.Supervisor do
  @moduledoc false
  


  use Supervisor

  def start_link(arg) do
#    arg = []
    Supervisor.start_link(__MODULE__, arg)
  end

#  def start_link(arg) do
#    Supervisor.start_link(__MODULE__, arg)
#  end

  def init(_arg) do
    import Supervisor.Spec
    children = [
#      worker(MyWorker, [arg], restart: :temporary)
      worker(Ers.WorkActor, []),
    ]

    supervise(children, strategy: :one_for_one)
  end
end