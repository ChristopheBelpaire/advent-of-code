Mix.install([:jason])
json = File.read!("./12.json")
|> Jason.decode!()


defmodule AOC12 do
  def parse(parent, count) do
    if is_map(parent) do
      if !Enum.any?(parent, fn({k, v}) -> k == "red" or v == "red" end) do
        Enum.reduce(parent, count, fn({child_key, child_value}, count) ->
          count = (if is_integer(child_key), do: count + child_key, else: count)
          count = if is_integer(child_value), do: count + child_value, else: count
          if is_list(child_value) or is_map(child_value), do: parse(child_value, count), else: count
        end)
      else
        count
      end
    else
      Enum.reduce(parent, count, fn(child_value, count) ->
        count = if is_integer(child_value), do: count + child_value, else: count
        if is_list(child_value) or is_map(child_value), do: parse(child_value, count), else: count
      end)
    end
  end
end

AOC12.parse(json, 0) |> IO.inspect()
