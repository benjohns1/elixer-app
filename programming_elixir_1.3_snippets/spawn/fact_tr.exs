defmodule NotTailRecursive do
  def factorial(0), do: 1

  # not tail-recursive (DOES add a new frame to the stack every call, 
  # because the result of factorial() needs to be multiplied by n)
  def factorial(n), do: n * factorial(n-1)
end

defmodule TailRecursive do
  def factorial(n), do: _fact(n, 1)
  defp _fact(0, acc), do: acc

  # uses tail recursion (which DOESN'T add a new frame to the stack because 
  # the recursive call is the last operation in the function)
  defp _fact(n, acc), do: _fact(n-1, acc*n)
end