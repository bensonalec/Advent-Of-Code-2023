defmodule Day3Test do
  use ExUnit.Case

  test "Day 3, Part 1, Example 1" do
    {:ok, inp} = File.read("./samples/d3p1ex.txt")
    answer = Aoc.Day3.part1(inp)
    IO.inspect answer
    assert answer == 4361
  end

  test "Day 3, Part 2, Example 1" do
    {:ok, inp} = File.read("./samples/d3p2ex.txt")
    answer = Aoc.Day3.part2(inp)
    IO.inspect answer
    assert answer == 467835
  end
end
