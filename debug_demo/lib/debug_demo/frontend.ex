defmodule DebugDemo.FrontEnd do
  use GenServer
  alias DebugDemo.WorkerPool, as: Pool

  # ----------------------------------------------------------------------
  # Interface
  # ----------------------------------------------------------------------
  def start_link do
    GenServer.start_link __MODULE__, [], name: __MODULE__
  end

  def do_thing(number) do
    GenServer.cast __MODULE__, {:thing, number}
  end

  # ----------------------------------------------------------------------
  # Callbacks
  # ----------------------------------------------------------------------
  def handle_cast({:thing, number}, state) do
    Pool.process_thing number
    {:noreply, state}
  end
end

