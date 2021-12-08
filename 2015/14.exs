"Vixen can fly 8 km/s for 8 seconds, but then must rest for 53 seconds.
Blitzen can fly 13 km/s for 4 seconds, but then must rest for 49 seconds.
Rudolph can fly 20 km/s for 7 seconds, but then must rest for 132 seconds.
Cupid can fly 12 km/s for 4 seconds, but then must rest for 43 seconds.
Donner can fly 9 km/s for 5 seconds, but then must rest for 38 seconds.
Dasher can fly 10 km/s for 4 seconds, but then must rest for 37 seconds.
Comet can fly 3 km/s for 37 seconds, but then must rest for 76 seconds.
Prancer can fly 9 km/s for 12 seconds, but then must rest for 97 seconds.
Dancer can fly 37 km/s for 1 seconds, but then must rest for 36 seconds."

input = [[8, 8, 53],
[13, 4, 49],
[20, 7, 132],
[12, 4, 43],
[9, 5, 38],
[10, 4, 37],
[3, 37, 76],
[9, 12, 97],
[37, 1, 36]
]

#input = [[14,10, 127], [16,11,162]]

Enum.map(input, fn([s, t, r])->
  distance  = div(2503, t + r) * s * t
  distance = distance + Enum.min([t, 2503 - div(2503, t + r) * (t + r)]) * s
end)
|> IO.inspect()
|> Enum.max()
|> IO.inspect()
