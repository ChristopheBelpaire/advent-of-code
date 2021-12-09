input = "2199943210
3987894921
9856789892
8767896789
9899965678"

Mix.install([{:nx, "~> 0.1.0-dev", github: "elixir-nx/nx", branch: "main", sparse: "nx"}])
defmodule AOC8 do
  def part1(input) do
    input = parse(input)
    input
    |> Enum.with_index()
    |> Enum.reduce(0, fn({line, y}, risk) ->
      line
      |> Enum.with_index()
      |> Enum.reduce(risk, fn({value, x}, risk) ->
        if low_point?(input , x, y, value) do
          risk + value + 1
        else
          risk
        end
      end)
    end)
  end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn (line) ->
      String.split(line, "", trim: true)
      |> Enum.map(&String.to_integer(&1))
    end)
  end

  def low_point?(input, x, y, value) do
    (at(input, x + 1, y) > value) &&
    (at(input, x - 1, y) > value) &&
    (at(input, x, y + 1) > value) &&
    (at(input, x, y - 1) > value)
  end

  def at(input, x, y) when x < 0 or y < 0, do: 10
  def at(input, x, y) do
    Enum.at(input, y, [])
    |> Enum.at(x, 10)
  end
end

AOC8.part1(input) |> IO.inspect()
