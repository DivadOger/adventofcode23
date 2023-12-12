defmodule Adventofcode23.Day2 do
  import Adventofcode23.FileReader

  @input_path "lib/day2/input.txt"
  @max_cubes %{
    "red" => 12,
    "green" => 13,
    "blue" => 14
  }

  def part1 do
    read(@input_path)
    |> split_lines()
    |> count_valid_games()
  end

  def part2 do
    read(@input_path)
    |> split_lines()
    |> count_sets_power()
  end

  defp count_valid_games(lines) do
    Enum.reduce(lines, 0, fn line, acc ->
      game_id = get_game_id(line)
      if is_valid_game(line), do: acc + game_id, else: acc
    end)
  end

  defp get_game_id(line) do
    Regex.run(~r/Game (\d+)/, line)
    |> transform_id_to_integer()
  end

  defp transform_id_to_integer(nil), do: 0
  defp transform_id_to_integer([_, n]), do: String.to_integer(n)

  defp is_valid_game(line) do
    Enum.all?(@max_cubes, fn {color, max} ->
      get_max_drawn_cubes_by_color(line, color) <= max
    end)
  end

  defp get_max_drawn_cubes_by_color(line, color) do
    Regex.scan(~r/(\d+) #{color}/, line)
    |> Enum.map(fn [_, n] -> String.to_integer(n) end)
    |> Enum.max()
  end

  defp count_sets_power(lines) do
    Enum.map(lines, &get_set_power(&1))
    |> Enum.sum()
  end

  defp get_set_power(line) do
    Enum.reduce(@max_cubes, 1, fn {color, _max}, cubes_power ->
      cubes_power * get_max_drawn_cubes_by_color(line, color)
    end)
  end
end
