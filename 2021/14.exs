
defmodule AOC14 do
  def part1(template, rules) do
    rules = rules
    |> String.split("\n")
    |> Enum.reduce(%{}, fn(line, rules) ->
      [k, v] = String.split(line," -> ")
      Map.put(rules, String.split(k, "", trim: true), v)
    end)

    template = template
    |> String.split("", trim: true)

    Enum.reduce(1..4, template, fn(step, template) ->
      template
      |> Enum.group_by(fn(x) -> x end)
      |> Enum.map(fn({el, e}) -> {el, Enum.count(e)} end)
     # |> IO.inspect()
      next_gen(template, rules)
    end)
    |> IO.inspect()
   # |> Enum.chunk_every(2, 1, :discard)
   # |> Enum.group_by(fn(x) -> x end)
   # |> Enum.map(fn({el, e}) -> {el, Enum.count(e)} end)
    |> Enum.group_by(fn(x) -> x end)
    |> Enum.map(fn({el, e}) -> {el, Enum.count(e)} end)

  end

  def next_gen(template, rules) do
    last_polymer = Enum.at(template, - 1)
    new_template = template
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn([first, second])->
      new_polymer = Map.get(rules, [first, second])
      [first, new_polymer]
    end)
    |> List.flatten()
    new_template ++ [last_polymer]
  end

  def part2(template, rules) do
    rules = rules
    |> String.split("\n")
    |> Enum.reduce(%{}, fn(line, rules) ->
      [k, v] = String.split(line," -> ")
      Map.put(rules, String.split(k, "", trim: true), v)
    end)

    counters = template
    |> String.split("", trim: true)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(%{}, fn(polymer, counters) ->
      Map.update(counters, polymer, 1, fn(p) -> p  + 1 end )
    end)

    frequencies =  template
    |> String.split("", trim: true)
    |> Enum.group_by(fn(p) -> p end)
    |> Enum.map(fn({p, c}) -> {p, Enum.count(c)} end)
    |> Enum.into(%{})
    |> IO.inspect(label: "freq")
    {couple_counters, polymer_counters} =
    Enum.reduce(1..40, {counters, frequencies}, fn(step, {counters, element_counters}) ->
      Enum.reduce(counters, {counters, element_counters}, fn({[a, c], counter}, {counters, element_counters}) ->
        b = Map.get(rules, [a,c])
        counters = counters
        |> Map.update([a, b], counter, fn(p) ->
          p + counter
        end )
        |> Map.update([b, c], counter, fn(p) ->
          p + counter
        end)
        |> Map.update([a, c], counter, fn(p) -> p - counter end)
        {counters, Map.update(element_counters, b, counter, fn(c) -> c + counter end)}
      end)
    end)

    polymer_counters

  end
end

rules = "FO -> K
FF -> H
SN -> C
CC -> S
BB -> V
FK -> H
PC -> P
PH -> N
OB -> O
PV -> C
BH -> B
HO -> C
VF -> H
HB -> O
VO -> N
HK -> N
OF -> V
PF -> C
KS -> H
KV -> F
PO -> B
BF -> P
OO -> B
PS -> S
KC -> P
BV -> K
OC -> B
SH -> C
SF -> P
NH -> C
BS -> C
VH -> F
CH -> S
BC -> B
ON -> K
FH -> O
HN -> O
HS -> C
KK -> V
OK -> K
VC -> H
HV -> F
FS -> H
OV -> P
HF -> F
FB -> O
CK -> O
HP -> C
NN -> V
PP -> F
FC -> O
SK -> N
FN -> K
HH -> F
BP -> O
CP -> K
VV -> S
BO -> N
KN -> S
SB -> B
SC -> H
OS -> S
CF -> K
OP -> P
CO -> C
VK -> C
NB -> K
PB -> S
FV -> B
CS -> C
HC -> P
PK -> V
BK -> P
KF -> V
NS -> P
SO -> C
CV -> P
NP -> V
VB -> F
KO -> C
KP -> F
KH -> N
VN -> S
NO -> P
NF -> K
CB -> H
VS -> V
NK -> N
KB -> C
SV -> F
NC -> H
VP -> K
PN -> H
OH -> K
CN -> N
BN -> F
NV -> K
SP -> S
SS -> K
FP -> S"

AOC14.part1("NNCB", rules) |> IO.inspect
AOC14.part2("FSHBKOOPCFSFKONFNFBB", rules) |> IO.inspect
