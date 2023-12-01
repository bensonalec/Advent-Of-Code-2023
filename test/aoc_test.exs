defmodule AocTest do
  use ExUnit.Case
  doctest Aoc

  test "Retrieve Input" do
    assert Aoc.get_input("1") |> String.starts_with?("heightseven4two5")
  end

end
