defmodule AOC15 do
  def combine(1, current) do
    score([100 - Enum.sum(current) |  current])
  end
  def combine(size, current) do
    Enum.reduce(0..(100 - Enum.sum(current)), [], fn(i, acc) ->
      [ combine(size - 1, [i | current]) | acc]
    end)
    |> List.flatten()
    #|> Enum.chunk_every(size)
  end

  def score([a, b, c, d]) do
    cap = cast(a * 5 + b * -1 + c * 0 + d * -1)
    dur = cast(a * -1 + b * 3 + c * -1 + d * 0)
    fla = cast(a * 0 + b * 0 + c * 4 + d * 0 )
    tex = cast(d * 2)
    cal = cast(a * 5 + b * 1 + c * 6 + d * 8)
    if cal == 500, do: cap * dur * fla * tex, else: 0

  end
  def cast(i) when i < 0, do: 0
  def cast(i), do: i

end

AOC15.combine(4, []) |> Enum.max() |> IO.inspect()

#AOC15.score([44, 56]) |> IO.inspect()
