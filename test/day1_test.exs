defmodule Day1Test do
  use ExUnit.Case

  test "Day 1, Part 1, Example 1" do
    {:ok, inp} = File.read("./samples/d1p1ex.txt")
    answer = Aoc.Day1.part1(inp)
    IO.inspect answer
    assert answer == 142
  end

  test "Day 1, Part 2, Example 1" do
    {:ok, inp} = File.read("./samples/d1p2ex.txt")
    answer = Aoc.Day1.part2(inp)
    IO.inspect answer
    assert answer == 281
  end

end
