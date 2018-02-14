defmodule Ticker do
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def tick_child(client_pid) do
    send :global.whereis_name(@name), { :tick_child, client_pid }
  end

  def generator(clients) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        if (length(clients) <= 0), do: send pid, { :tick } # if adding first client, start ticking
        generator(clients ++ [pid])
      { :tick_child, caller } ->
        # Given the caller's PID, find the next client in client list
        child_index = clients
        |> Enum.find_index(fn(pid) -> pid == caller end)
        |> get_next_index(length(clients))
        child_pid = Enum.at(clients, child_index)

        # Let caller know which PID to send tick message to
        send caller, { :tick_child, child_pid }
        generator(clients)
    end
  end

  defp get_next_index(parent_index, list_length) when list_length - 1 > parent_index, do: parent_index + 1
  defp get_next_index(_, _), do: 0

end

defmodule Client do
  @interval 2000

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts "client tick"
        :timer.sleep(@interval)
        Ticker.tick_child(self())
        receiver()
      { :tick_child, child_pid } ->
        IO.puts "sending tick to next client"
        send child_pid, { :tick }
        receiver()
    end
  end

end