defmodule AOC21 do
  def play(roll, dice, player, players) do
    players = Map.update(players, player, 0, fn({score, position}) ->
      new_score = score + case rem(position + dice * 3 + 3, 10) do
        0 -> 10
        p -> p
      end
      {new_score, rem(position + dice * 3 + 3, 10)}
    end)
    {roll + 3, rem(dice + 2, 100) + 1, players}
  end
end

Enum.reduce(1..170, {0, 1, %{1 => {0, 10}, 2 => {0, 3}}}, fn(_turn, {roll, dice, players}) ->
  {roll, dice, players} = AOC21.play(roll, dice, 1, players)
  AOC21.play(roll, dice, 2, players) |> IO.inspect()
end)
