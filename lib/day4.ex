defmodule Aoc.Day4 do
  def part1 do
    Aoc.get_input("4")
    |> do_part_1
  end

  def part1(inp) do
    do_part_1(inp)
  end

  defp do_part_1(inp) do
    inp |> String.split("\n", trim: true) |> reduce_input(&part_1_reduce_condition/3, []) |> Enum.sum
  end

  def part2 do
    Aoc.get_input("4")
    |> do_part_2
  end

  def part2(inp) do
    do_part_2(inp)
  end

  defp do_part_2(inp) do
    mapping = inp |> String.split("\n", trim: true) |> reduce_input(&part_2_reduce_condition/3, %{})
    Enum.map(Map.keys(mapping), fn x ->
      create_cards(mapping, x)
    end) |> List.flatten |> length
  end

  defp part_1_reduce_condition(com, acc, _) do
    if(MapSet.size(com) > 0) do
      acc ++ [:math.pow(2, MapSet.size(com)-1)]
    else
      acc ++ [0]
    end
  end

  defp part_2_reduce_condition(com, acc, id) do
    case MapSet.size(com) do
      z when z > 1 -> Map.put(acc, id, {MapSet.size(com), :math.pow(2, MapSet.size(com)-1), Range.new(id+1,id+MapSet.size(com))|> Enum.to_list})
      z when z == 1 -> Map.put(acc, id, {MapSet.size(com), :math.pow(2, MapSet.size(com)-1), Range.new(id+1,id+MapSet.size(com))|> Enum.to_list})
       _ -> Map.put(acc, id, {MapSet.size(com), 0, []})
     end
  end

  defp split_apart_input_line(line) do
    [id, winning, chosen] = Regex.split(~r/\||:/, line)
    winning = Regex.scan(~r/\d+/, winning) |> List.flatten
    chosen = Regex.scan(~r/\d+/, chosen) |> List.flatten
    {id, _} = Regex.scan(~r/\d+/, id) |> List.flatten |> Enum.at(0) |> Integer.parse
    {id, winning, chosen}
  end

  defp reduce_input(inp, reduce_function, acc) do
    Enum.reduce(inp, acc, fn x, acc ->
      {id, winning, chosen} = split_apart_input_line(x)
      com = MapSet.intersection(Enum.into(winning, MapSet.new), Enum.into(chosen, MapSet.new))
      reduce_function.(com, acc, id)
    end)
  end

  defp create_cards(mapping, card_number) do
    {_, _, new_cards} = Map.get(mapping, card_number)
    case new_cards do
      [] -> [card_number]
      _ -> Enum.concat([card_number],Enum.map(new_cards, fn x ->
        create_cards(mapping, x)
      end))
    end
  end

end
