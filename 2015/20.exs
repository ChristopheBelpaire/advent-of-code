defmodule AOC20 do
  def dicho(h, i) do
    p = Enum.reduce(1..h, 0, fn(i, acc) -> if rem(h, i) == 0, do: acc + i, else: acc end) * 10
    if p > 29000000 do
      IO.puts("#{h}: #{p}, #{i}")
      dicho(h - i, div(i,2) + 100)
    else
      dicho(h + i, i + 100)
    end
  end
end

AOC20.dicho(10000, 1000)
