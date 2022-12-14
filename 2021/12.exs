defmodule AOC12 do
  def part1(input) do
    input =input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "-"))

  # starts = Enum.filter(input, fn([s, _e]) -> s == "start" end)
  # Enum.reduce(starts, [], fn(start, paths)-> paths ++ find_path(input, start, [start], [])  end)
    #start = Enum.at(starts, 0)
    #find_path(input, start, [start], [])
    # AOC12.find_path_2(input, "kj", ["start", "dc", "HN", "kj", "HN"], []) |> IO.inspect()
    find_path_2(input, "start", [], [])
  end


  def find_path_2(map, nil, path, paths) do
    IO.inspect(Enum.reverse(["end" | path]) )
    paths
  end

  def find_path_2(map, "end", path, paths) do
    small_caves  = Enum.filter( path, fn(c) -> (String.downcase(c) == c) && (c != "end") && (c != "start") end)
    if (length(small_caves) - length(Enum.uniq(small_caves))) <= 1 do
      IO.inspect(Enum.reverse(["end" | path]) |> length)
    end
    [["end" | path]  | paths]
  end

  def find_path_2(map, position, path, paths) do
    next_caves = map
    # linked caves
    |> Enum.filter(fn(p) -> Enum.at(p, 0) == position || Enum.at(p, 1) == position end)
    # caves
    |> Enum.map(fn(p) -> if Enum.at(p, 0) == position, do: Enum.at(p, 1), else: Enum.at(p, 0) end)

  #  IO.inspect(path)
  #  IO.inspect(next_caves)

    nexts = Enum.filter(next_caves, &(!already_visited?(path, &1)))
  # IO.inspect(nexts)

    Enum.map(nexts ,fn(next) -> find_path_2(map, next, [position | path], paths) end)

    #find_path_2(map, hd(nexts), [position | path], paths)

  end

  def already_visited?(path, cave) do
    #visit_count = Enum.filter(path, fn(x) -> cave == x end) |> length()
    small_caves  = Enum.filter( path, fn(c) -> (String.downcase(c) == c) && (c != "end") && (c != "start") end)
    has_double_visit? = Enum.uniq(small_caves) != small_caves
    already_present? = Enum.find(path, fn(c) -> c == cave end) != nil
    cave == "start"  || (has_double_visit? && cave != "end" && (String.downcase(cave) == cave)  && already_present? )
  end

end


#AOC12.already_visited?(["a","a","b"], "b") |> IO.inspect()

AOC12.part1("CI-hb
IK-lr
vr-tf
lr-end
XP-tf
start-vr
lr-io
hb-qi
end-CI
tf-YK
end-YK
XP-lr
XP-vr
lr-EU
tf-CI
EU-vr
start-tf
YK-hb
YK-vr
start-EU
lr-CI
hb-XP
XP-io
tf-EU")

AOC12.already_visited?(["a","b"], "b")
