defmodule Debug do
  def print(value), do IO.puts "#{inspect value}"
  def print(value) when is_binary(value), do IO.puts value
  def print(value, prefix) when is_binary(value), do IO.puts "#{prefix}: #{value}"
  def print(value, prefix), do IO.puts "#{prefix}: #{inspect value}"
end