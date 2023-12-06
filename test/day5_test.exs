defmodule Day5Test do
  use ExUnit.Case

  test "Day 5, Part 1, Example 1" do
    {:ok, inp} = File.read("./samples/d5p1ex.txt")
    answer = Aoc.Day5.part1(inp)
    IO.inspect answer
    assert answer == 35
  end

  test "Day 5, Part 2, Example 1" do
    {:ok, inp} = File.read("./samples/d5p2ex.txt")
    answer = Aoc.Day5.part2(inp)
    IO.inspect answer
    assert answer == 46
  end
end
