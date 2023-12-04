defmodule Aoc.Day4 do
  def part1 do
    Aoc.get_input("4")
    |> do_part_1
  end

  def part1(inp) do
    do_part_1(inp)
  end

  defp do_part_1(inp) do
    inp |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      [id, winning, chosen] = Regex.split(~r/\||:/, x)
      winning = Regex.scan(~r/\d+/, winning) |> List.flatten
      chosen = Regex.scan(~r/\d+/, chosen) |> List.flatten
      com = MapSet.intersection(Enum.into(winning, MapSet.new), Enum.into(chosen, MapSet.new))
      if(MapSet.size(com) > 0) do
        :math.pow(2, MapSet.size(com)-1)
      else
        0
      end
    end) |> Enum.sum
  end

  def part2 do
    Aoc.get_input("4")
    |> do_part_2
  end

  def part2(inp) do
    do_part_2(inp)
  end

  defp do_part_2(inp) do
    mapping = inp |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn x, acc ->
      [id, winning, chosen] = Regex.split(~r/\||:/, x)
      winning = Regex.scan(~r/\d+/, winning) |> List.flatten
      chosen = Regex.scan(~r/\d+/, chosen) |> List.flatten
      com = MapSet.intersection(Enum.into(winning, MapSet.new), Enum.into(chosen, MapSet.new))
      {id, _} = Regex.scan(~r/\d+/, id) |> List.flatten |> Enum.at(0) |> Integer.parse
      case MapSet.size(com) do
       z when z > 1 -> Map.put(acc, id, {MapSet.size(com), :math.pow(2, MapSet.size(com)-1), Range.new(id+1,id+MapSet.size(com))|> Enum.to_list})
       z when z == 1 -> Map.put(acc, id, {MapSet.size(com), :math.pow(2, MapSet.size(com)-1), Range.new(id+1,id+MapSet.size(com))|> Enum.to_list})
        _ -> Map.put(acc, id, {MapSet.size(com), 0, []})
      end
    end)
    IO.inspect(mapping)

    Enum.map(Map.keys(mapping), fn x ->
      create_cards(mapping, x)
    end) |> List.flatten |>length
  end

  defp create_cards(mapping, card_number) do
    {_, _, new_cards} = Map.get(mapping, card_number)
    case new_cards do
      [] -> [card_number]
      _ -> Enum.concat([card_number],Enum.map(new_cards, fn x ->
        create_cards(mapping, x)
      end) |> List.flatten)
    end
  end

end
