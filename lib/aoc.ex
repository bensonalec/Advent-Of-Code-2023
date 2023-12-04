defmodule Aoc do

  def get_input(day) do
    url = "https://adventofcode.com/2023/day/" <> day <> "/input"
    headers = ["Cookie": "session=#{System.get_env("AOC_TOKEN")}"]

    HTTPoison.start
    {:ok ,response} = HTTPoison.get(url, headers)
    response.body
  end

  #takes in an x,y coordinate, as well as a width and height and returns a list of the neighbors coordinates as a tuples
  def get_neighbors_from_index({x, y}, {width, height}) do
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

  #given an index in a flat list, and the width and heihgt of a grid, convert to the 2D coordinates
  def convert_from_flat_to_grid(index, {width, height}) do
    x_coord = Integer.floor_div(index, width)
    y_coord = rem(index, height)
    {x_coord, y_coord}
  end

  #given the coordinates of an item in a string grid, return the value
  def get_elements_from_string_grid(element_indexes, grid) do
    grid = Enum.map(grid, fn x ->
      String.graphemes(x)
    end)
    {x, y} = element_indexes
    Enum.at(Enum.at(grid, x), y)
  end

  #find contiguous groups of ints in a flat list, make a list of them grouped
  def find_contiguous_ints(list) do
    list |> Enum.reduce([], fn
      x, [] -> [[x]]
      x, [head = [h | _] | tail] when x == h + 1 -> [[x | head] | tail]
      x, [head | tail] -> [[x], head | tail]
    end)
    |> Enum.map(&Enum.reverse/1)
    |> Enum.reverse
  end

  #get the value of all neighbors for a given list of coordinates
  def get_all_neighbors({width, height}, value_map, coordinates, grid, filter_fn) do
    Enum.map(coordinates, fn x ->
      neighbors = Aoc.get_neighbors_from_index(x, {width, height})
      filter_fn.(
        {Aoc.get_elements_from_string_grid(x, grid),
         Enum.reduce(neighbors, [], fn y, acc ->
           case Map.get(value_map, y) do
             nil -> acc
             val -> acc ++ [val]
           end
         end)
         |> Enum.dedup()}
      )
    end)
  end

end
