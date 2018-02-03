defmodule Chop do
  def guess(actual, first..last) when actual >= first and actual <= last and first <= last do
    mid = div(first+last,2)
    IO.puts "Is it #{mid}?"
    make_guess(actual, mid, first..last)
  end

  defp make_guess(actual, check, _) when actual == check, do: "Yes, it is #{check}"
  defp make_guess(actual, check, first.._) when actual < check, do: guess(actual, first..check)
  defp make_guess(actual, check, _..last) when check+1 == last, do: guess(actual, last..last)
  defp make_guess(actual, check, _..last) when actual > check, do: guess(actual, check..last)
end