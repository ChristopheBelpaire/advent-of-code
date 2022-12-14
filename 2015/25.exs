defmodule AOC25 do
  def at(x, y) do
    a =  div((x + 1) * x, 2)
    {p, _} =Enum.reduce(1..(y - 1), {a, x}, fn(y, {acc, add})-> {acc + add, add + 1} end)
    IO.inspect(p)
    Enum.reduce(1..(p-1), 20151125 , fn(_i, p)-> rem(p * 252533, 33554393) end)
  end
end

AOC25.at(3075, 2981 ) |> IO.inspect()
