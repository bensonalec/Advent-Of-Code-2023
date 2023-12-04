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
    symbols = get_symbols(inp, {width, height})
    value_map = create_int_map(inp, grid, {width, height})
    get_sum_of_neighbors({width, height}, value_map, symbols, grid, &part_1_filter/1)
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
    symbols = get_symbols(inp, {width, height})
    value_map = create_int_map(inp, grid, {width, height})
    get_sum_of_neighbors({width, height}, value_map, symbols, grid, &part_2_filter/1)
  end

  defp get_symbols(inp, {width, height}) do
    Regex.scan(~r/[^\.\d\n]/, inp |> String.replace("\n", ""), return: :index)
    |> List.flatten
    |> Enum.map(fn x ->
      {index, _} = x
      convert_from_flat_to_grid(index, {width, height})
    end)
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

  defp create_int_map(inp, grid, {width, height}) do
    number_indexes = Regex.scan(~r/\d/, inp |> String.replace("\n", ""), return: :index) |> List.flatten
    number_indexes = Enum.map(number_indexes, fn {ind, _} ->
      ind
    end)

    number_indexes |> Enum.reduce([], fn
      x, [] -> [[x]]
      x, [head = [h | _] | tail] when x == h + 1 -> [[x | head] | tail]
      x, [head | tail] -> [[x], head | tail]
    end)
    |> Enum.map(&Enum.reverse/1)
    |> Enum.reverse
    |> Enum.map(fn x ->
      convert_from_num_indexes_to_num_tuple(x, grid, {width, height})
    end)
    |> create_map_of_num_tups
  end

  defp get_sum_of_neighbors({width, height}, value_map, symbols, grid, filter_fn) do
    Enum.map(symbols, fn x ->
      neighbors = get_neighbors_from_index(x, {width, height})
      filter_fn.({get_elements_from_grid(x, grid), Enum.reduce(neighbors, [], fn y, acc ->
        case Map.get(value_map, y) do
          :nil -> acc
          val -> acc ++ [val]
        end
      end) |> Enum.dedup})
    end) |> List.flatten |> Enum.sum
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
    {str_val, coords} =  Enum.reduce(index_group, {"", []}, fn x, acc ->
      coords = convert_from_flat_to_grid(x, dimensions)
      value = get_elements_from_grid(coords, grid)
      {str_rep, coord_list} = acc
      {str_rep <> value, coord_list ++ [coords]}
    end)
    {val, _} = Integer.parse(str_val)
    {val, coords}

  end

  defp get_elements_from_grid(element_indexes, grid) do
    grid = Enum.map(grid, fn x ->
      String.graphemes(x)
    end)
    {x, y} = element_indexes
    Enum.at(Enum.at(grid, x), y)
  end



  defp get_neighbors_from_index({x, y}, {width, height}) do
    Enum.map(-1..1, fn i ->
      Enum.map(-1..1, fn j ->
          case {i, j} do
            {0, 0} -> []
            _ -> {x + i, y + j}
          end
      end)
    end) |> List.flatten
    |> Enum.filter(fn {i, j} ->
      !(i >= width || j >= height || i < 0 || j < 0)
    end)
  end

  defp convert_from_flat_to_grid(index, {width, height}) do
    x_coord = Integer.floor_div(index, width)
    y_coord = rem(index, height)
    {x_coord, y_coord}
  end
end
