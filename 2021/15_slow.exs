defmodule AOC15 do
  def next(path, x, y, max_x, max_y) do
    if [x, y] == [max_x, max_y], do: IO.inspect(path)
    {done?, x, y, path} = go_right(x, y, path, max_x, max_y)
    if done?, do: next(path, x, y, max_x, max_y)

    {done?, x, y, path} = go_down(x, y, path, max_x, max_y)
    if done?, do: next(path, x, y, max_x, max_y)

    {done?, x, y, path} = go_left(x, y, path, max_x, max_y)
    if done?, do: next(path, x, y, max_x, max_y)

    {done?, x, y, path} = go_up(x, y, path, max_x, max_y)
    if done?, do: next(path, x, y, max_x, max_y)
  end

  def go_right(x, y, path, x, _), do: {false, x, y ,path}

  def go_right(x, y, path, _, _), do: add_to_path(x + 1, y, path)

  def go_down(x, y, path, _, y), do: {false, x, y ,path}
  def go_down(x, y, path, _, _), do: add_to_path(x, y + 1, path)

  def go_left(0, _y, path, _, _), do: {false, path}
  def go_left(x, y, path, _, _), do: add_to_path(x - 1, y, path)

  def go_up(x, 0, path, x, _y), do: {false, path}
  def go_up(x, y, path, _, _), do: add_to_path(x, y - 1, path)

  def add_to_path(x, y, path) do
    if(!Enum.find(path, fn(coordinates)-> coordinates == [x, y] end)) do
      {true, x, y, [[x, y] | path]}
    else
      {false, x, y, path}
    end
  end
end

AOC15.next([], 0, 0, 100, 100)
