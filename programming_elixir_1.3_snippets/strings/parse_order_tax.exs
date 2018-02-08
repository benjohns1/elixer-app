defmodule ParseOrderTax do

  def calculate_tax(orders, tax_rates) do
    for order <- orders do
      tax_rate = Access.get(tax_rates, order[:ship_to], 0)
      Keyword.put(order, :total_amount, tax_rate * order[:net_amount] + order[:net_amount])
    end
  end

  def parse_orders(filename \\ "strings\\orders.csv") do
    {:ok, file} = File.open(filename, [:read])
    IO.read(file, :line) #ignore header line
    for line <- IO.stream(file, :line) do
      [str_id | [str_state | [str_net_amount]]] = String.split(line, ",") |> Enum.map(&(String.trim(&1)))
      [id: String.to_integer(str_id), ship_to: String.to_atom(String.trim(str_state, ":")), net_amount: String.to_float(str_net_amount)]
    end
  end
  
end

tax_rates = [ NC: 0.075, TX: 0.08 ]

IO.puts inspect ParseOrderTax.parse_orders |> ParseOrderTax.calculate_tax(tax_rates)