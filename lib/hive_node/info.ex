defmodule HiveNode.Info do
  use GenServer
  require Logger

  @name :node_info

  def start_link(args) do
    GenServer.start_link(__MODULE__, :ok, [{:name, @name} | args])
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call(:get_cpu, _from, state) do
    {cpu, _other_chars} = "top -bn 2 -d 0.01 | grep '^%Cpu' | tail -n 1 | gawk '{print $2+$4+$6}'"
    |> String.to_charlist
    |> :os.cmd
    |> List.to_string
    |> Float.parse
    {:reply, cpu, state}
  end

end
