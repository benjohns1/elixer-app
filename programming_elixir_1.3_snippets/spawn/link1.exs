defmodule Link1 do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run do
    spawn(__MODULE__, :sad_function, [])
    receive do
      msg -> IO.puts "Message Received: #{inspect msg}"
      after 1000 -> IO.puts "Nothing happened afaik"
    end
  end
end

Link1.run()