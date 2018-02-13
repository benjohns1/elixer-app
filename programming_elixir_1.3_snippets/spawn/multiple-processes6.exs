defmodule Parallel do
  def pmap(collection, fun) do
    parent = self() # store parent PID so it can be referenced in closure sent to spawn_link
    collection
    |> Enum.map(fn (elem) -> spawn_link fn -> (send parent, { self(), fun.(elem) }) end end)
    |> Enum.map(fn (pid) -> receive do { ^pid, result } -> result end end)
  end
end