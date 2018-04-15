defmodule HiveNode.Node do
  use GenServer
  require Logger

  @name :node_manager


  def start_link(args) do
    GenServer.start_link(__MODULE__, :ok, [{:name, @name} | args])
  end

  def init(:ok) do
    {:ok, pid} = Application.get_env(:hive_node, :node_name)
    |> Node.start
    Application.get_env(:hive_node, :cookie)
    |> Node.set_cookie
    {:ok, %{node: pid}}
  end

  def get_connected_nodes() do
    GenServer.call(@name, :get_connected_nodes)
  end

  def handle_call(:get_connected_nodes, _from, state) do
    {:reply, Node.list, state}
  end
end
