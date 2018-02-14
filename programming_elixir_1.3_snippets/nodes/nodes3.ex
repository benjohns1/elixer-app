defmodule Ticker do
  @interval 2000
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[],[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  # send tick to clients in round-robin fashion based on when they registered
  def generator(this_round, clients) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        generator(this_round ++ [pid], clients ++ [pid])
      after @interval ->
        IO.puts "tick - Clients left this round: #{inspect this_round}"
        case this_round do
          [] ->
            # no clients in round, keep looping
            generator(clients, clients)
          [client | remaining] ->
            # send tick to next client
            send client, { :tick }
            if remaining == [] do
              generator(clients, clients)
            else
              generator(remaining, clients)
            end
        end
    end
  end

end

defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts "tock in client"
        receiver()
    end
  end

end