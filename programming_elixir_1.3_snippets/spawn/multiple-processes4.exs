defmodule MultipleProcesses do
  def say(parent) do
    send parent, "My PID: #{inspect self()}"
    raise "Exception raised in child process"
  end

  def run(n \\ 1) do
    for _ <- 1..n, do: spawn_link(__MODULE__, :say, [self()])
    # with spawn_link, when the child process raises an exception the parent 
    # process exits even if parent hasn't started to listen for messages yet
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