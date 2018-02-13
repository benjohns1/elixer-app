# Run in terminal with:
#    $> elixir -r multiple-processes7.exs

ExUnit.start()

defmodule Parallel do
  use ExUnit.Case

  def pmap(collection, fun) do
    parent = self()
    collection
    |> Enum.map(fn (elem) -> spawn_link fn -> (send parent, { self(), fun.(elem) }) end end)
    # Here's the race condition: PID should be pinned via ^pid to keep map collection responses in order
    |> Enum.map(fn (pid) -> receive do { _pid, result } -> result end end)
  end

  test "ordering of process results is maintained" do
    # This probably works on most systems
    assert pmap(1..4, &(&1 * &1)) == [1,4,9,16]

    # Mapping over this function (which waits half a second every odd integer) shows ordering error
    assert pmap(1..6, fn x ->
      if Integer.mod(x, 2) == 0 do
        x
      else
        :timer.sleep(500)
        x
      end
    end) == [1,2,3,4,5,6]
  end

end