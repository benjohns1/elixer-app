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
end