Enum.reduce(1..50, [1,1,1,3,2,2,2,1,1,3], fn(x, acc) ->
  IO.puts(x)
  {c, i, acc} = Enum.reduce(acc, {hd(acc) ,0,[]}, fn(p, {c, i, acc}) ->
    if p==c do
      {p, i + 1, acc}
    else
      {p, 1,  [c, i] ++ acc}
    end
  end)
  Enum.reverse([c, i] ++ acc)
end)
|> length()
|> IO.puts
