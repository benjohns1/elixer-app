defmodule Stack2.Server do
  use GenServer

  #####
  # External API

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(value) do
    GenServer.cast __MODULE__, {:push, value}
  end

  # End External API
  #####

  #####
  # GenServer implementation

  def init(stash_pid) do
    current_stack = Stack2.Stash.get_value(stash_pid)
    { :ok, {current_stack, stash_pid} }
  end

  def handle_call(:pop, _from, []) do
    raise "Empty stack, cannot pop any more values"
    { :reply, nil, [] }
  end

  def handle_call(:pop, _from, {[stack_head | stack_tail], stash_pid}) do
    { :reply, stack_head, {stack_tail, stash_pid}}
  end

  def handle_cast({:push, value}, {stack, stash_pid}) do
    { :noreply, {[ value | stack ], stash_pid}}
  end

  def terminate(_reason, {stack, stash_pid}) do
    Stack2.Stash.save_value(stash_pid, stack)
  end

  # End GenServer implementation
  #####
end