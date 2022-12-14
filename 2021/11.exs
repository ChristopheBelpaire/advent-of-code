defmodule AOC11 do

  def part1(input) do
    input= parse(input)

    input = {0, input}
    Enum.reduce(0..99, input, fn(_, input) ->
      input
      |> update_all(fn(x) -> x + 1 end)
      |> flash()
      |> update_all(fn(el) -> if el > 9, do: 0, else: el end)
    end)
  end

  def part2(input) do
    input= parse(input)
    input = {0, input}
    simultanous?(input, 1)
  end

  def simultanous?(input, gen) do
    {flashes, next} = input
    |> update_all(fn(x) -> x + 1 end)
    |> flash()
    |> update_all(fn(el) -> if el > 9, do: 0, else: el end)
    if List.flatten(next) |> Enum.uniq() == [0], do: gen, else: simultanous?({flashes, next}, gen + 1)
  end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn (line) ->
      String.split(line, "", trim: true)
      |> Enum.map(&String.to_integer(&1))
    end)
  end

  def flash({flashes, input}) do
    input
    |> Enum.with_index()
    |> Enum.reduce({flashes, input}, fn({line, y}, {flashes, input}) ->
      line
      |> Enum.with_index()
      |> Enum.reduce({flashes, input}, fn({_el, x}, {flashes, input}) ->
           if at(input, x, y) == 10 do
              next = input
              |> update_at(x, y, fn(v) -> v + 1 end)
              |> update_at( x - 1, y, &inc_if_not_blow/1)
              |> update_at( x + 1, y, &inc_if_not_blow/1)
              |> update_at( x, y + 1, &inc_if_not_blow/1)
              |> update_at( x, y - 1, &inc_if_not_blow/1)
              |> update_at( x + 1, y + 1, &inc_if_not_blow/1)
              |> update_at( x - 1, y - 1, &inc_if_not_blow/1)
              |> update_at( x + 1, y - 1, &inc_if_not_blow/1)
              |> update_at( x - 1, y + 1, &inc_if_not_blow/1)
              flash({flashes + 1, next})
            else
              {flashes, input}
           end
      end)
    end)
  end

  def inc_if_not_blow(v), do: if v != 10, do: v + 1, else: v

  def at(_input, x, y) when x < 0 or y < 0, do: nil
  def at(input, x, y) do
    Enum.at(input, y, [])
    |> Enum.at(x, nil)
  end

  def update_at(input, x, y, _update_fn) when x < 0 or y < 0, do: input
  def update_at(input, x, y, update_fn) when y < length(input) do
    if x >= (Enum.at(input, y) |> length) do input
    else
      List.update_at(input, y, fn(line) -> List.update_at(line, x, update_fn) end)
    end
  end
  def update_at(input, x, y, update_fn) do
    List.update_at(input, y, fn(line) -> List.update_at(line, x, update_fn) end)
  end

  def update_all({flashes, input}, update_fn) do
    {flashes, Enum.map(input, fn(line) ->
      Enum.map(line, update_fn)
    end)}
  end
end

AOC11.part1("5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526") |> IO.inspect()
