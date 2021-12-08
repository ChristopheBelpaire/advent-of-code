defmodule AOC13 do
  def permutations([]), do: [[]]
  def permutations(list), do: for elem <- list, rest <- permutations(list--[elem]), do: [elem|rest]
end
