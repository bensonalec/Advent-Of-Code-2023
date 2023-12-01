defmodule Mix.Tasks.CreateDay do
  use Mix.Task

  def run([day]) do
    IO.puts("Generating file...")
    app_dir = File.cwd!
    new_file_path_core = Path.join(
        [app_dir, "lib", "day#{day}.ex"]
    )
    new_file_path_test = Path.join(
        [app_dir, "test", "day#{day}_test.exs"]
    )

    new_file_path_ex1 = Path.join(
      [app_dir, "samples", "d#{day}p1ex.txt"]
    )
    new_file_path_ex2 = Path.join(
      [app_dir, "samples", "d#{day}p2ex.txt"]
    )

    readme_path = Path.join(
      [app_dir, "README.md"]
    )

    File.write(
      new_file_path_ex1,
      "",
      [:write]
    )
    File.write(
      new_file_path_ex2,
      "",
      [:write]
    )

    File.write(
      new_file_path_core,
      """
      defmodule Aoc.#{String.capitalize("day#{day}")} do
        def part1 do
          Aoc.get_input("#{day}")
          |> do_part_1
        end

        def part1(inp) do
          do_part_1(inp)
        end

        defp do_part_1(inp) do
          "some answer"
        end

        def part2 do
          Aoc.get_input("#{day}")
          |> do_part_2
        end

        def part2(inp) do
          do_part_2(inp)
        end

        defp do_part_2(inp) do
          "some answer"
        end
      end
      """,
      [:write]
    )

    File.write(
      new_file_path_test,
      """
      defmodule Day#{day}Test do
        use ExUnit.Case

        test "Day #{day}, Part 1, Example 1" do
          {:ok, inp} = File.read("./samples/d#{day}p1ex.txt")
          answer = Aoc.Day#{day}.part1(inp)
          IO.inspect answer
          assert answer == "some answer"
        end

        test "Day #{day}, Part 2, Example 1" do
          {:ok, inp} = File.read("./samples/d#{day}p2ex.txt")
          answer = Aoc.Day#{day}.part2(inp)
          IO.inspect answer
          assert answer == "some answer"
        end
      end
      """,
      [:write]
    )
    File.write(
      readme_path,
      "| #{day}        |        |        |
      ",
      [:append, {:delayed_write, 100, 20}])

  end
end
