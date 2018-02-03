defmodule GCD do
  def between(x,0), do: x
  def between(x,y), do: between(y, rem(x,y))
end