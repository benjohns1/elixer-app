defmodule Stack.Server do
  use GenServer

  def handle_call(:pop, _from, []) do
    { :reply, nil, [] }
  end

  def handle_call(:pop, _from, [stack_head | stack_tail]) do
    { :reply, stack_head, stack_tail}
  end

  def handle_cast({:push, value}, stack) do
    { :noreply, [ value | stack ]}
  end
end