input = "addx 2
addx 3
addx 1
noop
addx 4
addx 1
noop
addx 28
addx -24
noop
addx 5
addx 17
addx -16
noop
addx 6
noop
addx -7
addx 11
addx 4
noop
addx 1
addx -36
addx -2
noop
noop
addx 10
noop
noop
addx -2
addx 2
addx 25
addx -18
addx 23
addx -22
addx 2
addx 5
addx -10
addx -15
addx 28
addx 2
addx 5
addx 2
addx -16
addx 17
addx -36
noop
noop
addx 39
addx -32
addx -5
addx 7
addx 1
addx 5
addx -13
addx 1
addx 17
addx 1
noop
addx 7
noop
addx -2
addx 2
addx 5
addx 2
noop
noop
noop
noop
addx -37
noop
noop
noop
noop
addx 6
addx 11
addx -7
addx 29
addx -22
addx 5
noop
noop
noop
addx 3
noop
addx 7
addx -28
addx 24
addx 3
addx 2
noop
addx 2
noop
addx 3
addx -38
noop
addx 7
addx -2
addx 1
addx 6
addx -10
addx 38
addx -25
addx 5
addx 2
addx -10
addx 11
addx 2
noop
addx 3
addx 2
noop
addx 3
addx 2
addx 5
addx -39
addx 1
addx 1
addx 3
addx 2
addx 4
addx 29
addx -23
noop
addx -1
addx 5
noop
addx 11
addx -10
addx 5
addx -1
noop
addx 3
noop
addx 3
addx 4
noop
noop
noop
noop
noop"

interresting_cycle? = fn(cycle) ->
  cycle == 20 || rem(cycle + 20, 40) == 0
end

is_lit? = fn(cycle, x) ->
  x = x + div(cycle, 40) * 40
  (cycle == x) || (cycle == (x + 1)) || (cycle == (x + 2))
end

# input
# |> String.split("\n")
# |> Enum.reduce({0, 1}, fn(instruction,{cycle, x}) ->
#     {cycle, x} = if(instruction == "noop") do
#       if interresting_cycle?.(cycle), do: IO.puts("Cycle : #{cycle} strength: #{cycle  * x}")
#       {cycle + 1, x}
#     else
#       cycle = cycle + 1
#       if interresting_cycle?.(cycle), do: IO.puts("Cycle : #{cycle} strength: #{cycle  * x}")
#       cycle = cycle + 1
#       ["addx", to_add] = String.split(instruction, " ")
#       if interresting_cycle?.(cycle), do: IO.puts("Cycle : #{cycle} strength: #{cycle  * x}")

#       to_add =  String.to_integer(to_add)

#       {cycle, x + to_add}
#     end
#     {cycle, x}
# end)



{_cycle, _x, screen} = input
|> String.split("\n")
|> Enum.reduce({0, 0, List.duplicate(".", 40 * 6)}, fn(instruction, {cycle, x, screen}) ->
    {cycle, x, screen} = if(instruction == "noop") do
      screen = if is_lit?.(cycle, x), do: List.update_at(screen, cycle, fn(v)-> "#" end), else: screen
      {cycle + 1, x, screen}
    else
      screen = if is_lit?.(cycle, x), do: List.update_at(screen, cycle, fn(v)-> "#" end), else: screen
      cycle = cycle + 1
      screen = if is_lit?.(cycle, x), do: List.update_at(screen, cycle, fn(v)-> "#" end), else: screen
      cycle = cycle + 1

      ["addx", to_add] = String.split(instruction, " ")
      to_add =  String.to_integer(to_add)
      {cycle, x + to_add, screen}
    end
    {cycle, x, screen}
end)
screen
|> Enum.chunk_every(40)
|> Enum.map(&(Enum.join(&1)))
|> Enum.join("\n")
|> IO.puts
