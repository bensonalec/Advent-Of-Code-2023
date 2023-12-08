defmodule Day7Test do
  use ExUnit.Case

  test "Day 7, Part 1, Example 1" do
    {:ok, inp} = File.read("./samples/d7p1ex.txt")
    answer = Aoc.Day7.part1(inp)
    IO.inspect answer
    assert answer == 6440
  end

  test "Day 7, Part 2, Example 1" do
    {:ok, inp} = File.read("./samples/d7p2ex.txt")
    answer = Aoc.Day7.part2(inp)
    IO.inspect answer
    assert answer == 5905
  end
end
