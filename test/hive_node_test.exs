defmodule HiveNodeTest do
  use ExUnit.Case
  doctest HiveNode

  test "greets the world" do
    assert HiveNode.hello() == :world
  end
end
