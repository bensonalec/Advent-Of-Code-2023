defmodule Aoc.Day5 do
  def part1 do
    Aoc.get_input("5")
    |> do_part_1
  end

  def part1(inp) do
    do_part_1(inp)
  end

  defp between(st, en, val) do
    val >= st  and val <= en
  end

  defp do_part_1(inp) do
    first_line = String.split(inp, "\n") |> Enum.at(0)
    seeds = Regex.scan(~r/\d+/, first_line) |> List.flatten |> Enum.map(fn z -> elem(Integer.parse(z),0) end)
    mappings = Regex.scan(~r/(?<=map:\n)(?:\d+ \d+ \d+\n)+\d+ \d+ \d+/, inp)
    |> List.flatten
    |> Enum.map(fn x ->
      String.split(x, "\n")
      |> Enum.map(fn y ->
        [dest, source, range] = Regex.scan(~r/\d+/, y) |> List.flatten |> Enum.map(fn z -> elem(Integer.parse(z),0) end)
        range = range - 1
        {{source,source+range}, dest}
      end)
    end)
    Enum.map(seeds, fn x ->
      Enum.reduce(mappings, x, fn y, acc ->
        Enum.reduce_while(y, acc, fn z, acc_z ->
          {{st, en}, dest_start} = z
          if between(st, en, acc_z) do
            {:halt, abs(st-acc_z) + dest_start}
          else
            {:cont, acc_z}
          end
        end)
      end)
    end) |> Enum.min
  end

  def part2 do
    Aoc.get_input("5")
    |> do_part_2
  end

  def part2(inp) do
    do_part_2(inp)
  end

  defp do_part_2(inp) do
    first_line = String.split(inp, "\n") |> Enum.at(0)
    seeds = Regex.scan(~r/\d+/, first_line) |> List.flatten |> Enum.map(fn z -> elem(Integer.parse(z),0) end)
    |> Enum.chunk_every(2)
    mappings = Regex.scan(~r/(?<=map:\n)(?:\d+ \d+ \d+\n)+\d+ \d+ \d+/, inp)
    |> List.flatten
    |> Enum.map(fn x ->
      String.split(x, "\n")
      |> Enum.map(fn y ->
        [source, dest, range] = Regex.scan(~r/\d+/, y) |> List.flatten |> Enum.map(fn z -> elem(Integer.parse(z),0) end)
        range = range - 1
        {{source,source+range}, dest}
      end)
    end)
    mappings = mappings |> Enum.reverse
    inp = (0..100000000000000000000000000)
    Enum.reduce_while(inp, {}, fn x, _ ->
      val = Enum.reduce(mappings, x, fn y, acc ->
        Enum.reduce_while(y, acc, fn z, acc_z ->
          {{st, en}, dest_start} = z
          if between(st, en, acc_z) do
            {:halt, abs(st-acc_z) + dest_start}
          else
            {:cont, acc_z}
          end
        end)
      end)
      Enum.reduce(seeds, false, fn i, acc ->
        [start, en] = i
        acc || between(start, start+en-1, val)
      end)
      |> case do
        true -> {:halt, x}
        false -> {:cont, x}
      end
    end)
  end
end
