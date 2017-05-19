defmodule DebugDemo.ThingProcessor do
  use GenServer
  #
  # ----------------------------------------------------------------------
  # Interface
  # ----------------------------------------------------------------------
  def start_link do
    GenServer.start_link __MODULE__, 0
  end

  def process(pid, number) do
    GenServer.cast pid, {:process, number}
  end

  # ----------------------------------------------------------------------
  # Callbacks
  # ----------------------------------------------------------------------
  def handle_cast({:process, number}, state) do
    IO.puts "Processing #{number}; original state was #{state}"
    process_number number
  end

  # ----------------------------------------------------------------------
  # Helpers
  # ----------------------------------------------------------------------
  defp process_number(number) when number > 10 do
    {:stop, :normal, number}
  end

  defp process_number(number) do
      {:noreply, number}
  end
end

