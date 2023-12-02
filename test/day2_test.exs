defmodule Day2Test do
  use ExUnit.Case

  test "Day 2, Part 1, Example 1" do
    {:ok, inp} = File.read("./samples/d2p1ex.txt")
    answer = Aoc.Day2.part1(inp)
    IO.inspect answer
    assert answer == 8
  end

  test "Day 2, Part 2, Example 1" do
    {:ok, inp} = File.read("./samples/d2p2ex.txt")
    answer = Aoc.Day2.part2(inp)
    IO.inspect answer
    assert answer == 2286
  end
end
