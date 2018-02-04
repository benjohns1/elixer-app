# print helper
defmodule Debug do
  def print(value) when is_binary(value), do: IO.puts value
  def print(value), do: IO.puts "#{inspect value}"
  def print(value, prefix) when is_binary(value), do: IO.puts "#{prefix}: #{value}"
  def print(value, prefix), do: IO.puts "#{prefix}: #{inspect value}"
end

import Debug

# concatenate/map
list = Enum.to_list 1..5
print(list)
Enum.concat([1,2,3], [4,5,6]) |> print
Enum.concat([1,2,3], 'abc') |> print
Enum.map(list, &(&1 * 10)) |> print
Enum.map(list, &String.duplicate("*", &1)) |> print

# select elements
Enum.at(10..20, 3) |> print
Enum.at(10..20, 20) |> print
Enum.at(10..20, 20, :no_one_here) |> print
Enum.filter(list, &(&1 > 2)) |> print
require Integer
Enum.filter(list, &Integer.is_even/1) |> print
Enum.reject(list, &Integer.is_even/1) |> print

# sort and compare
sort_list = ["there", "was", "a", "crooked", "man"]
Enum.sort(sort_list) |> print
Enum.sort(sort_list, &(String.length(&1) <= String.length(&2))) |> print
Enum.max(sort_list) |> print
Enum.max_by(sort_list, &String.length/1) |> print

# split collections
Enum.take(list, 3) |> print
Enum.take_every(list, 2) |> print
Enum.take_while(list, &(&1 < 4)) |> print
Enum.split(list, 2) |> print
Enum.split_while(list, &(&1 < 4)) |> print
list2 = list ++ [4,3,2,1]
print(list2)
Enum.split_while(list2, &(&1 < 4)) |> print
Enum.split_with(list2, &(&1 < 4)) |> print

# join collections
Enum.join(list) |> print
Enum.join(list, ",") |> print

# predicate operations
Enum.all?(list, &(&1 < 4)) |> print
Enum.any?(list, &(&1 < 4)) |> print
Enum.member?(list, 4) |> print
Enum.empty?(list) |> print

# merge operations
Enum.zip(list, [:a, :b, :c]) |> print
Enum.with_index(["once", "upon", "a", "time"]) |> print

# fold elements into single value
Enum.reduce(1..100, &(&1 + &2)) |> print
Enum.reduce(["now", "is", "the", "time"], fn word, longest -> 
  if String.length(word) > String.length(longest) do
    word
  else
    longest
  end
end) |> print
Enum.reduce(["now", "is", "the", "time"], 0, fn word, longest ->
  if String.length(word) > longest, do: String.length(word), else: longest
end) |> print

# deal hand of cards
import Enum
deck = for rank <- '23456789TJQKA', suit <- 'CDHS', do: [suit, rank]
print deck
deck |> shuffle |> take(13) |> print
hands = deck |> shuffle |> chunk(13)
print hands