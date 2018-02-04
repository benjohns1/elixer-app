s = Stream.map [1,3,5,7], &(&1 + 1)
IO.puts inspect s
IO.puts inspect Enum.to_list s

squares = Stream.map [1,2,3,4], &(&1*&1)
plus_ones = Stream.map squares, &(&1+1)
odds = Stream.filter plus_ones, fn x -> rem(x,2) == 1 end
IO.puts inspect Enum.to_list odds

IO.puts inspect [1,2,3,4]
|> Stream.map(&(&1*&1))
|> Stream.map(&(&1+1))
|> Stream.filter(fn x -> rem(x,2) == 1 end)
|> Enum.to_list