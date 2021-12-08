input = "199
200
208
210
200
207
240
269
260
263"

input = String.split(input,"\n")
|> Enum.map(&String.to_integer(&1))
|> Enum.reduce({0, 0},fn(value, {count, previous})->
   if value > previous do
    {count + 1, value}
  else
    {count, value}
  end
end)
|> IO.inspect()

defmodule M do
  def measurement([first, second, third], previous, counter) do
    value = first + second + third
    if value > previous do
      counter + 1
    else
      counter
    end
  end

  def measurement([first, second, third | rest], previous, counter) do
      value = first + second + third
      if value > previous do
        measurement([second, third | rest], value, counter + 1)
      else
        measurement([second, third | rest], value, counter)
      end
  end
end

#M.measurement(input, :infinity, 0) |> IO.inspect()
