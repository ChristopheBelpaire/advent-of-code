defmodule AOC23 do
  def part1(input) do
    String.split(input,"\n")
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> run(%{"a" => 1, "b" => 0}, 0)
  end

  def run(instructions, mem, p) do
    Enum.at(instructions, p)
    case inst(Enum.at(instructions, p), mem, p) do
      {:stop, mem, p} -> {mem, p}
      {mem, p} -> run(instructions, mem, p)
    end
  end

  def inst(["hlf", r], mem, p), do: {Map.update!(mem, r, fn(v) -> div(v, 2) end), p + 1}
  def inst(["tpl", r], mem, p), do: {Map.update!(mem, r, fn(v) -> v * 3 end), p + 1}
  def inst(["inc", r], mem, p), do: {Map.update!(mem, r, fn(v) -> v + 1 end), p + 1}
  def inst(["jmp", j], mem, p), do: {mem, p + String.to_integer(j)}
  def inst(["jie", r, j], mem, p), do: {mem, (if (rem(Map.fetch!(mem, r), 2) == 0), do: p + String.to_integer(j), else: p + 1)}
  def inst(["jio", r, j], mem, p), do: {mem, (if (Map.fetch!(mem, r) == 1), do: p + String.to_integer(j), else: p + 1)}
  def inst(nil, mem, p), do: {:stop, mem, p}
end

input = "jio a +16
inc a
inc a
tpl a
tpl a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
tpl a
tpl a
inc a
jmp +23
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
tpl a
inc a
inc a
tpl a
inc a
tpl a
inc a
tpl a
inc a
inc a
tpl a
inc a
tpl a
tpl a
inc a
jio a +8
inc b
jie a +4
tpl a
inc a
jmp +2
hlf a
jmp -7"

AOC23.part1(input) |> IO.inspect()
