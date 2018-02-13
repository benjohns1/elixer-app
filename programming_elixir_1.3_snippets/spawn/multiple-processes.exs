defmodule MultipleProcesses do
  def echo(caller) do
    receive do
      :halt -> send caller, :halt
      val -> send caller, {:ok, val}
    end
  end

  def listen do
    receive do
      :halt -> IO.puts "Halting"
      {:ok, val} when is_binary(val) ->
        IO.puts val
        listen()
      {:ok, val} ->
        IO.puts "#{inspect val}"
        listen()
    end
  end

  def run do
    p1 = spawn(__MODULE__, :echo, [self()])
    p2 = spawn(__MODULE__, :echo, [self()])

    send p1, "Alpha"
    send p2, "Omega"

    halter = spawn(__MODULE__, :echo, [self()])
    send halter, :halt

    listen()
  end
end