defmodule StringsAndBinaries do

  # Returnes true if all characters are printable
  def all_printable?([]), do: true
  def all_printable?([ head | tail ]) when head >= ?\s and head <= ?~, do: all_printable?(tail)
  def all_printable?(_invalid_list), do: false

  # Test for an anagram
  def anagram?(word1, word2), do: word1 -- word2 == [] and word2 -- word1 == []

  # Parse simple arithmetic string
  def calculate(str) do
    first = _parse_number(str, 0)
    op = _parse_op(first[:str])
    second = _parse_number(op[:str], 0)
    case op[:op] do
      ?+ -> first[:val] + second[:val]
      ?- -> first[:val] - second[:val]
      ?* -> first[:val] * second[:val]
      ?/ -> first[:val] / second[:val]
      op -> raise "Invalid operator #{op}"
    end
  end
  defp _parse_number([], value), do: [val: value, str: '']
  defp _parse_number([ char | tail ], value) when char in '0123456789', do: _parse_number(tail, value*10 + char - ?0)
  defp _parse_number([ ?\s | tail ], value), do: _parse_number(tail, value) # ignore leading/trailing spaces
  defp _parse_number(string, value), do: [val: value, str: string]
  defp _parse_op([ char | tail ]) when char in '+-*/', do: [op: char, str: tail]

  # Center a list of strings
  def center(string_list), do: _center(string_list, _max_length(string_list, 0))
  defp _center([], _), do: :ok
  defp _center([ str | tail ], width) do
    current_length = String.length(str)
    pad_length = div((width - current_length), 2) + current_length
    IO.puts String.pad_leading(str, pad_length)
    _center(tail, width)
  end
  defp _max_length([], len), do: len
  defp _max_length([ str | tail ], len) do
    test_len = String.length(str)
    if test_len > len do
      _max_length(tail, test_len)
    else
      _max_length(tail, len)
    end
  end

  # Capitalize sentences delimited exactly with a period and a space
  def capitalize_sentences(str), do: _capitalize_substrings(str, ". ")
  defp _capitalize_substrings(str, substr), do: _ucfirst_list(String.split(str, substr), substr)
  defp _ucfirst_list([], _), do: ""
  defp _ucfirst_list([ head | [] ], _append), do: String.capitalize(head)
  defp _ucfirst_list([ head | tail ], append), do: String.capitalize(head) <> append <> _ucfirst_list(tail, append)
end