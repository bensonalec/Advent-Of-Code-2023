defmodule Aoc.Day1 do
  def part1 do
    Aoc.get_input("1")
    |> do_part_1
  end

  def part1(inp) do
    do_part_1(inp)
  end

  defp do_part_1(inp) do
    inp
    |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      create_int_from_two_strings(
        x |> find_first_integer |> elem(1) |> to_string(),
        x |> String.reverse() |> find_first_integer |> elem(1) |> to_string()
      )
    end)
    |> Enum.sum()
  end

  def part2 do
    Aoc.get_input("1")
    |> do_part_2
  end

  def part2(inp) do
    do_part_2(inp)
  end

  defp do_part_2(inp) do
    inp
    |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      (compare_ints(
         x |> find_first_integer,
         x |> find_lowest_text_digit(:no_reverse)
       ) <>
         compare_ints(
           x |> String.reverse() |> find_first_integer,
           x |> String.reverse() |> find_lowest_text_digit(:reverse)
         ))
      |> Integer.parse()
      |> elem(0)
    end)
    |> Enum.sum()
  end

  defp determine_digits(:no_reverse) do
    ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
  end

  defp determine_digits(:reverse) do
    determine_digits(:no_reverse) |> Enum.map(fn x -> String.reverse(x) end)
  end

  defp find_lowest_text_digit(inp, reverse_flag) do
    0..8
    |> Enum.map(fn y ->
      case :binary.match(inp, Enum.at(determine_digits(reverse_flag), y)) do
        {val, _} -> {val, y + 1}
        _ -> {10000, -1}
      end
    end)
    |> Enum.min()
  end

  defp compare_ints(str, dig) do
    str
    |> case do
      nil -> dig
      _ -> Enum.min([str, dig])
    end
    |> case do
      {_, val} -> to_string(val)
      _ -> :broke
    end
  end

  defp create_int_from_two_strings(first, last) do
    (first <> last)
    |> Integer.parse()
    |> elem(0)
  end

  defp find_first_integer(inp) do
    y =
      inp
      |> String.graphemes()
      |> Enum.find_index(fn y ->
        case Integer.parse(y) do
          {_, _val} -> y
          _ -> false
        end
      end)

    if y != nil do
      {y, elem(Integer.parse(String.at(inp, y)), 0)}
    else
      nil
    end
  end
end
