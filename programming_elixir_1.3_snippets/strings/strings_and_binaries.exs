defmodule StringsAndBinaries do

  # Returnes true if all characters are printable
  def all_printable?([]), do: true
  def all_printable?([ head | tail ]) when head >= ?\s and head <= ?~, do: all_printable?(tail)
  def all_printable?(_invalid_list), do: false

  # Test for an anagram
  def anagram?(word1, word2), do: word1 -- word2 == [] and word2 -- word1 == []

  # Parse basic arithmetic string
  def calculate(str), do: IO.puts "todo"
end