defmodule ErsTest do
  use ExUnit.Case
  doctest Ers

  test "greets the world" do
    assert Ers.hello() == :world
  end
end
