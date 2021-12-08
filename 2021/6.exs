#input = "8"
#|> String.split(",")
#|> Enum.map(&String.to_integer(&1))
#|> IO.inspect()

#Enum.reduce(1..3, input,fn(x, input) ->
#  zero_count = Enum.count(input, fn(i) -> i == 0 end)
#  new = List.duplicate(8, zero_count)
#  out = (Enum.map(input, fn(n) -> if n==0, do: 6, else: n - 1 end) ++ new)
#  IO.puts("After day #{x} : #{length(out)}")
#  out
#end)

input = "1,5,5,1,5,1,5,3,1,3,2,4,3,4,1,1,3,5,4,4,2,1,2,1,2,1,2,1,5,2,1,5,1,2,2,1,5,5,5,1,1,1,5,1,3,4,5,1,2,2,5,5,3,4,5,4,4,1,4,5,3,4,4,5,2,4,2,2,1,3,4,3,2,3,4,1,4,4,4,5,1,3,4,2,5,4,5,3,1,4,1,1,1,2,4,2,1,5,1,4,5,3,3,4,1,1,4,3,4,1,1,1,5,4,3,5,2,4,1,1,2,3,2,4,4,3,3,5,3,1,4,5,5,4,3,3,5,1,5,3,5,2,5,1,5,5,2,3,3,1,1,2,2,4,3,1,5,1,1,3,1,4,1,2,3,5,5,1,2,3,4,3,4,1,1,5,5,3,3,4,5,1,1,4,1,4,1,3,5,5,1,4,3,1,3,5,5,5,5,5,2,2,1,2,4,1,5,3,3,5,4,5,4,1,5,1,5,1,2,5,4,5,5,3,2,2,2,5,4,4,3,3,1,4,1,2,3,1,5,4,5,3,4,1,1,2,2,1,2,5,1,1,1,5,4,5,2,1,4,4,1,1,3,3,1,3,2,1,5,2,3,4,5,3,5,4,3,1,3,5,5,5,5,2,1,1,4,2,5,1,5,1,3,4,3,5,5,1,4,3"

i = input
|> String.split(",")
|> Enum.map(&String.to_integer(&1))
|> Enum.reduce([0, 0, 0, 0, 0, 0, 0, 0, 0], fn(x, acc) ->
  List.update_at(acc, x, fn(x)-> x + 1 end)
end)

Enum.reduce(1..256, i, fn(d, p) ->
  [at_zero | rest] = p
  rest = rest
  |> List.update_at(6, fn(x) -> x + at_zero end)
  rest ++ [at_zero]
end)
|> Enum.sum() |> IO.inspect()
