defmodule Adventofcode23.FileReader do
  def read(path) do
    File.read!(path)
  end

  def split_lines(content) do
    String.split(content, "\n")
  end
end
