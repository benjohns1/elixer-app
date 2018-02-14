defmodule Stack.Server4 do
  use GenServer

  #####
  # External API

  def start_link(initial_stack \\ []) do
    GenServer.start_link(__MODULE__, initial_stack, name: __MODULE__)
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(value) do
    GenServer.cast __MODULE__, {:push, value}
  end

  def manual_halt(code) do
    GenServer.cast __MODULE__, {:halt, code}
  end

  # End External API
  #####

  #####
  # GenServer implementation

  def handle_call(:pop, _from, []) do
    { :reply, nil, [] }
  end

  def handle_call(:pop, _from, [stack_head | stack_tail]) do
    { :reply, stack_head, stack_tail}
  end

  def handle_cast({:push, value}, stack) do
    { :noreply, [ value | stack ]}
  end

  def handle_cast({:halt, code}, stack) do
    raise "Exception #{inspect code}"
    { :noreply, stack }
  end

  def terminate(reason, state) do
    IO.puts "#{__MODULE__} terminating: #{inspect reason}\nwith state: #{inspect state}"
  end

  # End GenServer implementation
  #####
end