defmodule AOC20 do
  def dicho(h, a, b) do
    p = Enum.reduce(1..h, 0, fn(i, acc) -> if rem(h, i) == 0, do: acc + i, else: acc end) * 10
    next = div(b - a, 2)
    IO.puts("#{a}: #{b}, #{next}")

    if p > 29000000 do
      dicho(next, next, b)
    else
    #  IO.puts("#{h}: #{p}, #{div(b - a, 2)}")
      dicho(next,  a, next)
    end
  end
end

#AOC20.dicho(1, 1, 10000000)


max = 70000

Enum.reduce(1..100, List.duplicate(0, max),fn(e, houses) ->
  Enum.reduce(1..div(max, e), houses, fn(p, houses) -> List.update_at(houses, p * e, fn(v)-> v + e * 10 end) end)
end)
|> IO.inspect()
|> tl()
|> Enum.max()
|> IO.inspect()
