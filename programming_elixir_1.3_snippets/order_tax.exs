
defmodule OrderTax do
  def calculate_tax(tax_rates, orders) do
    for order <- orders do
      tax_rate = Access.get(tax_rates, order[:ship_to], 0)
      Keyword.put(order, :total_amount, tax_rate * order[:net_amount] + order[:net_amount])
    end
  end
end

tax_rates = [ NC: 0.075, TX: 0.08 ]

orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount: 35.50 ],
  [ id: 125, ship_to: :TX, net_amount: 24.00 ],
  [ id: 126, ship_to: :TX, net_amount: 44.80 ],
  [ id: 127, ship_to: :MD, net_amount: 21.50 ]
]

IO.puts inspect OrderTax.calculate_tax(tax_rates, orders)