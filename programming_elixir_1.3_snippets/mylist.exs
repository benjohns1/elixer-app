defmodule MyList do
  def len([]), do: 0
  def len([_head|tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head|tail]), do: [ head * head | square(tail) ]

  def add_1([]), do: []
  def add_1([head|tail]), do: [ head + 1 | add_1(tail) ]

  def map([],_func), do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]

  def sum(list), do: _sum(list, 0)
  defp _sum([], total), do: total
  defp _sum([ head | tail ], total), do: _sum(tail, head + total)

  # sum function w/o using an accumulator
  def sum2([]), do: 0
  def sum2([ head | tail ]), do: head + sum2(tail)

  # general reduce function
  def reduce([], value, _), do: value
  def reduce([ head | tail ], value, func), do: reduce(tail, func.(head, value), func)

  # applies function to each element, sums result
  def mapsum([], _func), do: 0
  def mapsum([ head | tail ], func), do: func.(head) + mapsum(tail, func)

  # returns element with max value in list
  def max([ head | tail ]), do: _max(tail, head)
  def _max([], current_max), do: current_max
  def _max([ head | tail ], current_max) when head > current_max, do: _max(tail, head)
  def _max([ _ | tail ], current_max), do: _max(tail, current_max)

  def caesar([], _n), do: []
  def caesar([ head | tail ], n), do: [ _caesar_wrap(head + n) | caesar(tail, n) ]
  def _caesar_wrap(value) when value > 122, do: _caesar_wrap(value - 26)
  def _caesar_wrap(value) when value < 97, do: _caesar_wrap(26 + value)
  def _caesar_wrap(value), do: value

  # Returns a list of number from 'from' up to 'to'
  def span(from, to) when not is_integer(from) or not is_integer(to), do: raise "Both parameters must be integers"
  def span(from, to) when from > to, do: raise "'from' must be less than 'to'"
  def span(from, to) when from == to, do: [from]
  def span(from, to), do: [from | span(from + 1, to)]

  # Manual Enum.all? implementation
  def all?([], _func), do: true
  def all?([ head | tail ], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end

  # Manual Enum.each implementation
  def each([], _func), do: :ok
  def each([ head | tail ], func) do
    func.(head)
    each(tail, func)
  end

  # Manual Enum.filter implementation
  def filter([], _func), do: []
  def filter([ head | tail ], func) do
    if func.(head) do
      [ head | filter(tail, func) ]
    else
      filter(tail, func)
    end
  end

  # Manual Enum.split implementation
  def split(enum, count) when count >= 0, do: _split([], enum, count)
  def split(enum, count) when count < 0, do: _split([], enum, _reverse_list_position(enum, 0, count))
  defp _split(first, second, count) when count <= 0 or second == [], do: {Enum.reverse(first), second}
  defp _split(first, [ head | tail ], count) when count > 0, do: _split([ head | first ], tail, count - 1)

  # Negative index position helper function
  defp _reverse_list_position([], positive, negative) do
    position = positive + negative
    if position >= 0 do
      position
    else
      0
    end
  end
  defp _reverse_list_position([ _head | tail ], positive, negative), do: _reverse_list_position(tail, positive + 1, negative)

  # Manual Enum.take implementation
  def take(list, amount) when amount == 0 or list == [], do: []
  def take([ head | tail ], amount) when amount > 0, do: [ head | take(tail, amount - 1) ]
  def take(list, amount) when amount < 0, do: _ignore_until(list, _reverse_list_position(list, 0, amount))

  # Return remaining list after index (opposite of Enum.take)
  defp _ignore_until(list, index) when list == [] or index <= 0, do: list
  defp _ignore_until([ _head | tail ], index), do: _ignore_until(tail, index - 1)

  # Flatten
  def flatten([]), do: []
  def flatten([ head | tail ]) do
    if is_list(head) do
      flatten(head) ++ flatten(tail)
    else
      [ head | flatten(tail) ]
    end
  end

  # List primes from 2 to n, using list comprehension
  def list_primes(n) do
    for x <- span(2, n), prime?(x), do: x
  end
  def prime?(2), do: true
  def prime?(3), do: true
  def prime?(n) do
    max = n
    |> :math.sqrt
    |> :math.ceil
    |> :erlang.trunc

    not (span(2,max)
    |> Enum.filter(&(rem(&1,2) != 0 or &1 == 2)) 
    |> Enum.any?(&(rem(n,&1) == 0)))
  end
end