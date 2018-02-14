defmodule Stack2Test do
  use ExUnit.Case

  test "server pop" do
    assert { :reply, 1, {[2,3], :stash_pid}} == Stack2.Server.handle_call(:pop, :from, {[1,2,3], :stash_pid})
  end

  test "server push" do
    assert { :noreply, {[0,1,2,3], :stash_pid}} == Stack2.Server.handle_cast({:push, 0}, {[1,2,3], :stash_pid})
  end

  test "stash get value" do
    assert { :reply, [1,2,3], [1,2,3] } == Stack2.Stash.handle_call(:get_value, :from, [1,2,3])
  end

  test "stash save value" do
    assert { :noreply, [:a,:b,:c] } == Stack2.Stash.handle_cast({:save_value, [:a,:b,:c]}, [1,2,3])
  end

end
