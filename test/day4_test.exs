defmodule Day4Test do
  use ExUnit.Case

  test "Day 4, Part 1, Example 1" do
    {:ok, inp} = File.read("./samples/d4p1ex.txt")
    answer = Aoc.Day4.part1(inp)
    IO.inspect answer
    assert answer == 13
  end

  test "Day 4, Part 2, Example 1" do
    {:ok, inp} = File.read("./samples/d4p2ex.txt")
    answer = Aoc.Day4.part2(inp)
    IO.inspect answer
    assert answer == 30
  end
end
