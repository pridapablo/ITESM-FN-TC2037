defmodule HwTest do
  use ExUnit.Case
  doctest Hw

  test "greets the world" do
    assert Hw.hello() == :world
  end

  test "double the number" do
    assert Hw.double(0) == 0
    assert Hw.double(1) == 2
    assert Hw.double(4) == 8
    assert Hw.double(-4) == -8
  end
end
