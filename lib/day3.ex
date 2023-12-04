defmodule Aoc.Day3 do
  def part1 do
    Aoc.get_input("3")
    |> do_part_1
  end

  def part1(inp) do
    do_part_1(inp)
  end

  defp do_part_1(inp) do
    grid = String.split(inp, "\n", trim: true)
    {width, height} = {String.length(Enum.at(grid, 0)), length(grid)}
    symbols = get_symbol_indexes(inp, {width, height})
    value_map = create_int_map(inp, grid, {width, height})
    Aoc.get_all_neighbors({width, height}, value_map, symbols, grid, &part_1_filter/1) |> List.flatten() |> Enum.sum()
  end

  def part2 do
    Aoc.get_input("3")
    |> do_part_2
  end

  def part2(inp) do
    do_part_2(inp)
  end

  defp do_part_2(inp) do
    grid = String.split(inp, "\n", trim: true)
    {width, height} = {String.length(Enum.at(grid, 0)), length(grid)}
    symbols = get_symbol_indexes(inp, {width, height})
    value_map = create_int_map(inp, grid, {width, height})
    Aoc.get_all_neighbors({width, height}, value_map, symbols, grid, &part_2_filter/1) |> List.flatten() |> Enum.sum()

  end

  defp part_1_filter({_, neighbor_values}) do
    neighbor_values
  end

  defp part_2_filter({symbol, neighbor_values}) do
    if symbol == "*" && length(neighbor_values) == 2 do
      Enum.product(neighbor_values)
    else
      0
    end
  end

  defp get_symbol_indexes(inp, {width, height}) do
    Regex.scan(~r/[^\.\d\n]/, inp |> String.replace("\n", ""), return: :index)
    |> List.flatten()
    |> Enum.map(fn {index, _} ->
      Aoc.convert_from_flat_to_grid(index, {width, height})
    end)
  end

  defp create_int_map(inp, grid, {width, height}) do
    Regex.scan(~r/\d/, inp |> String.replace("\n", ""), return: :index) |> List.flatten()
    |> Enum.map(fn {ind, _} ->
        ind
    end)
    |> Aoc.find_contiguous_ints()
    |> Enum.map(fn x ->
      convert_from_num_indexes_to_num_tuple(x, grid, {width, height})
    end)
    |> create_map_of_num_tups
  end

  defp create_map_of_num_tups(num_tup_list) do
    Enum.reduce(num_tup_list, %{}, fn x, acc ->
      {val, coord_list} = x

      Enum.reduce(coord_list, acc, fn y, acc_y ->
        Map.put(acc_y, y, val)
      end)
    end)
  end

  defp convert_from_num_indexes_to_num_tuple(index_group, grid, dimensions) do
    {str_val, coords} =
      Enum.reduce(index_group, {"", []}, fn x, acc ->
        coords = Aoc.convert_from_flat_to_grid(x, dimensions)
        value = Aoc.get_elements_from_string_grid(coords, grid)
        {str_rep, coord_list} = acc
        {str_rep <> value, coord_list ++ [coords]}
      end)

    {val, _} = Integer.parse(str_val)
    {val, coords}
  end
end
