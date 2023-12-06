defmodule Day6Test do
  use ExUnit.Case

  test "Day 6, Part 1, Example 1" do
    {:ok, inp} = File.read("./samples/d6p1ex.txt")
    answer = Aoc.Day6.part1(inp)
    IO.inspect answer
    assert answer == 288
  end

  test "Day 6, Part 2, Example 1" do
    {:ok, inp} = File.read("./samples/d6p2ex.txt")
    answer = Aoc.Day6.part2(inp)
    IO.inspect answer
    assert answer == 71503
  end
end
