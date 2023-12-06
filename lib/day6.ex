defmodule Aoc.Day6 do
  def part1 do
    Aoc.get_input("6")
    |> do_part_1
  end

  def part1(inp) do
    do_part_1(inp)
  end

  defp do_part_1(inp) do
    String.split(inp, "\n", trim: true)
    |> Enum.reduce([], fn x, acc ->
      values = Regex.scan(~r/\d+/, x) |> List.flatten |>  Enum.map(fn i -> elem(Integer.parse(i), 0) end)
      |> Enum.with_index
      acc ++ values
    end)
    |> Enum.reduce(%{}, fn x, acc ->
      {val, ind} = x
      to_add = Map.get(acc, ind, {})
      final_val = Tuple.append(to_add, val)
      Map.put(acc, ind, final_val)
    end)
    |> Map.values |> Enum.map(fn {time , distance} ->
      Enum.map(0..time, fn ti ->
        speed = ti
        time_to_run = time - ti
        final_val = speed * time_to_run
        final_val > distance
      end) |> Enum.count(fn i -> i end)
    end) |> Enum.product
  end

  def part2 do
    Aoc.get_input("6")
    |> do_part_2
  end

  def part2(inp) do
    do_part_2(inp)
  end

  defp do_part_2(inp) do
    String.split(inp, "\n", trim: true)
    |> Enum.reduce([], fn x, acc ->
      x = String.replace(x, " ", "")
      values = Regex.scan(~r/\d+/, x) |> List.flatten |>  Enum.map(fn i -> elem(Integer.parse(i), 0) end)
      |> Enum.with_index
      acc ++ values
    end)
    |> Enum.reduce(%{}, fn x, acc ->
      {val, ind} = x
      to_add = Map.get(acc, ind, {})
      final_val = Tuple.append(to_add, val)
      Map.put(acc, ind, final_val)
    end)
    |> Map.values |> Enum.map(fn {time , distance} ->
      Enum.map(0..time, fn ti ->
        speed = ti
        time_to_run = time - ti
        final_val = speed * time_to_run
        final_val > distance
      end) |> Enum.count(fn i -> i end)
    end) |> Enum.product
  end
end
