defmodule Aoc do

  def get_input(day) do
    url = "https://adventofcode.com/2023/day/" <> day <> "/input"
    headers = ["Cookie": "session=#{System.get_env("AOC_TOKEN")}"]

    HTTPoison.start
    {:ok ,response} = HTTPoison.get(url, headers)
    response.body
  end


end
