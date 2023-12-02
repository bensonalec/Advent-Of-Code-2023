defmodule Aoc.Day2 do

  def part1 do
    Aoc.get_input("2")
    |> do_part_1
  end

  def part1(inp) do
    do_part_1(inp)
  end

  defp do_part_1(inp) do
    goal = %{"red"=> 12, "green"=> 13, "blue"=> 14}
    games = inp
    |> String.trim
    |> String.split("\n")
    |> Enum.map(fn x ->
      x = String.replace(x, " ", "")
      Regex.scan(~r/[\d+\w+,]*\d+\w+;/, x <> ";")
      |> List.flatten()
      |> Enum.map(fn y ->
        Regex.scan(~r/\d+\w+/, y)
        |> List.flatten()
        |> Enum.reduce(%{}, fn z, acc ->
          parts =
            Regex.scan(~r/\d+|\w+/, z)
            |> List.flatten()
          acc |> Map.put(
            Enum.at(parts, 1),
            elem(Integer.parse(Enum.at(parts, 0)), 0)
          )
        end)
        # |> IO.inspect
      end)
    end)
    |> Enum.with_index
    # |> IO.inspect

    Enum.filter(games, fn x ->
      {plays, _game_id} = x
      Enum.map(plays, fn y ->
        Enum.map(y, fn z ->
          {key, value} = z
          case Map.fetch(goal, key) do
            :error -> false
            {:ok, val} -> value <= val
          end
        end)
      end)
      |> List.flatten
      |> Enum.all?
    end)
    |> Enum.map(fn x ->
      {_game, game_id} = x
      game_id + 1
    end)
    |> Enum.sum
  end

  def part2 do
    Aoc.get_input("2")
    |> do_part_2
  end

  def part2(inp) do
    do_part_2(inp)
  end

  defp do_part_2(inp) do
    games = inp
    |> String.trim
    |> String.split("\n")
    |> Enum.map(fn x ->
      x = String.replace(x, " ", "")

      Regex.scan(~r/[\d+\w+,]*\d+\w+;/, x <> ";")
      |> List.flatten()
      |> Enum.map(fn y ->
        Regex.scan(~r/\d+\w+/, y)
        |> List.flatten()
        |> Enum.reduce(%{}, fn z, acc ->
          parts =
            Regex.scan(~r/\d+|\w+/, z)
            |> List.flatten()
          acc |> Map.put(
            Enum.at(parts, 1),
            elem(Integer.parse(Enum.at(parts, 0)), 0)
          )
        end)
      end)
      |> Enum.reduce(%{}, fn current_map, acc ->
        Map.merge(acc, current_map, fn _k, v1, v2 ->
          if(v1 >= v2) do
            v1
          else
            v2
          end
        end)
      end)
      |> Map.values
      |> Enum.product
    end)
    |> Enum.sum
    |> IO.inspect
  end
end
