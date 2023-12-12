defmodule Adventofcode23.Day1 do
  import Adventofcode23.FileReader

  @input_path "lib/day1/input.txt"
  @number_map [
    ["one", "1"],
    ["two", "2"],
    ["three", "3"],
    ["four", "4"],
    ["five", "5"],
    ["six", "6"],
    ["seven", "7"],
    ["eight", "8"],
    ["nine", "9"]
  ]

  def part1 do
    read(@input_path)
    |> split_lines()
    |> get_calibration_sum()
  end

  def part2 do
    read(@input_path)
    |> split_lines()
    |> clean_lines()
    |> get_calibration_sum()
  end

  defp get_calibration_sum(content) do
    content
    |> Enum.map(&get_line_calibration_value(&1))
    |> Enum.sum()
  end

  defp get_line_calibration_value(line) do
    Regex.scan(~r/\d/, line)
    |> merge_digits()
  end

  defp merge_digits([]), do: 0

  defp merge_digits(list) do
    String.to_integer("#{Enum.at(list, 0)}#{Enum.at(list, -1)}")
  end

  defp clean_lines(content) do
    content
    |> Enum.map(&clean_line(&1))
  end

  defp clean_line(line) do
    Enum.reduce(@number_map, line, fn [k, v], acc ->
      String.replace(acc, k, "#{k}#{v}#{k}")
    end)
    |> String.replace(Enum.map(@number_map, &hd/1), "")
  end
end
