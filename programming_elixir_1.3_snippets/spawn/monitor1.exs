defmodule Monitor1 do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run do
    res = spawn_monitor(__MODULE__, :sad_function, [])
    IO.puts inspect res
    receive do
      msg -> IO.puts "Message Received: #{inspect msg}"
      after 1000 -> IO.puts "Nothing happened afaik"
    end
  end
end

Monitor1.run()