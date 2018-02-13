defmodule MultipleProcesses do
  def say_with_exit(parent) do
    send parent, "My PID: #{inspect self()}"
    exit(:end)
  end

  def say_with_exception(parent) do
    send parent, "My PID: #{inspect self()}"
    raise "Exception raised in child process"
  end

  def run_with_exit(n \\ 1) do
    for _ <- 1..n, do: spawn_monitor(__MODULE__, :say_with_exit, [self()])
    # with spawn_monitor, when the child process exits the parent receives a
    # ":DOWN" exit message in its mailbox, in order
    :timer.sleep 500
    listen()
  end

  def run_with_exception(n \\ 1) do
    for _ <- 1..n, do: spawn_monitor(__MODULE__, :say_with_exception, [self()])
    # with spawn_monitor, when the child process raises an exception the parent 
    # receives a ":DOWN" exception message in its mailbox, in order
    :timer.sleep 500
    listen()
  end

  def listen do
    receive do
      response ->
        IO.puts "RESPONSE: #{inspect response}"
        listen()
      after 10000 -> IO.puts "Listen timeout"
    end
  end
end