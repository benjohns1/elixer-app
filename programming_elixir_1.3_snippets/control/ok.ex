defmodule Ok do
  def ok!({:ok, data}), do: data
  def ok!({atom, error}), do: raise "#{atom}: #{error}"
end