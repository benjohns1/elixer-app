defmodule Sequence2.Server do
  use GenServer

  #####
  # External API

  def start_link(current_number \\ 0) do
    GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  end

  def next_number do
    GenServer.call __MODULE__, :next_number
  end

  def increment_number(delta \\ 1) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end

  # End External API
  #####

  #####
  # GenServer implementation

  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number, current_number+1 }
  end

  def handle_cast({:increment_number, delta}, current_number) do
    { :noreply, current_number + delta }
  end

  def format_status(_reason, [ _pdict, state ]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end

  # End GenServer implementation
  #####
end