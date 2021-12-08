defmodule AOC17 do
  def permutations([], current, acc) do
    {[], [current | acc]}
  end
  def permutations(list, current, acc) do
    Enum.reduce(list, {current, acc}, fn(e, {current, acc} ) ->
      rest = list -- [e]
      {_, acc} = permutations(rest, [e | current ], acc)
      {current, acc}
    end)
  end

  def find_sum([], c), do: 0

  def find_sum(list, counter) do
    if Enum.sum(counter) == 25, do: IO.inspect(counter)
    list
    |> Enum.with_index()
    |> Enum.reduce(counter, fn({e, i}, counter) ->
      list2 = Enum.slice(list, (i + 1)..-1)
      find_sum(list2, [e | counter])
      #IO.inspect(list2)
      counter
    end)
  end

end

input = "11
30
47
31
32
36
3
1
5
3
32
36
15
11
46
26
28
1
19
3
0" |> String.split("\n")
|> Enum.map(&String.to_integer(&1))
#|> IO.inspect()

input = [20, 15, 10, 5, 5, 0]
AOC17.find_sum(input, []) |> IO.inspect()
