input = "1
2
-3
3
-2
0
4"


defmodule GrovePositioningSystem do
  def move({[h | t], c, current}) do
    index = Enum.find_index(current, fn(x) -> x == h end)
    next = current
    |> List.delete_at(index)
    |> List.insert_at(index + h, h)

    {t, c + 1, next }
  end
end

input = input
|> String.split("\n")
|> Enum.map(&(String.to_integer(&1)))


IO.inspect(input)
GrovePositioningSystem.move({input, 0, input})
|> IO.inspect()
|> GrovePositioningSystem.move()
|> IO.inspect()
|> GrovePositioningSystem.move()
|> IO.inspect()
