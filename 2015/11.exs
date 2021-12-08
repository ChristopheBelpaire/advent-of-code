
(String.to_integer("p", 26) + 15) |> Integer.to_string(26)

Enum.map(["a","b","c"], fn(c) -> String.to_integer(c, 36) end)

v = Enum.map(["a","b","c", "x", "y", "y"], fn(c) -> (String.to_integer(c, 35) - 9) |> Integer.to_string(27) end)
|> Enum.join()
|> IO.inspect()
|> String.to_integer(27)

v = v + 2

Integer.to_string(v, 27)
|> String.split("", trim: true)
|> Enum.map(fn(c) ->
  (String.to_integer(c, 27) + 9)
  |> IO.inspect()
  |> Integer.to_string(35)
end)
|> IO.inspect()
