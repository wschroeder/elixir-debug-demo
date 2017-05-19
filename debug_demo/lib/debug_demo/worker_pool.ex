defmodule DebugDemo.WorkerPool do
  use Supervisor
  alias DebugDemo.ThingProcessor, as: ThingProcessor

  # ----------------------------------------------------------------------
  # Interface
  # ----------------------------------------------------------------------
  def start_link do
    Supervisor.start_link [], [strategy: :one_for_one, name: __MODULE__]
  end

  def init([]) do
    {:ok, {}}
  end

  def process_thing(number) do
    import Supervisor.Spec, warn: false

    {:ok, pid} = Supervisor.start_child __MODULE__, worker(ThingProcessor, [], id: :erlang.unique_integer, restart: :transient)
    ThingProcessor.process(pid, number)
  end
end

