
input = "AlphaCentauri to Snowdin = 66
AlphaCentauri to Tambi = 28
AlphaCentauri to Faerun = 60
AlphaCentauri to Norrath = 34
AlphaCentauri to Straylight = 34
AlphaCentauri to Tristram = 3
AlphaCentauri to Arbre = 108
Snowdin to Tambi = 22
Snowdin to Faerun = 12
Snowdin to Norrath = 91
Snowdin to Straylight = 121
Snowdin to Tristram = 111
Snowdin to Arbre = 71
Tambi to Faerun = 39
Tambi to Norrath = 113
Tambi to Straylight = 130
Tambi to Tristram = 35
Tambi to Arbre = 40
Faerun to Norrath = 63
Faerun to Straylight = 21
Faerun to Tristram = 57
Faerun to Arbre = 83
Norrath to Straylight = 9
Norrath to Tristram = 50
Norrath to Arbre = 60
Straylight to Tristram = 27
Straylight to Arbre = 81
Tristram to Arbre = 90"
|> String.split("\n")
|> Enum.reduce(%{}, fn(line, acc)->
  [cities, distance] = String.split(line," = ")
  [from, to] = String.split(cities, " to ")
  Map.put(acc, [from, to], String.to_integer(distance))
  |> Map.put([to, from], String.to_integer(distance))
end )
IO.inspect(input)

defmodule AOC9 do
  def permutations([]), do: [[]]
  def permutations(list), do: for elem <- list, rest <- permutations(list--[elem]), do: [elem|rest]
end

Enum.map(input, fn{[from, to], _d}-> [from, to] end) |> List.flatten() |> Enum.uniq()
|> AOC9.permutations()
|> Enum.map(fn(p) ->
  p
  |> Enum.chunk_every(2, 1, :discard)
  |> Enum.reduce(0, fn(k, d)-> IO.inspect(k); Map.get(input, k) + d end)
end)
|> Enum.max()
|> IO.inspect()
