defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: BitString do
  def encrypt(string, shift) do
    string
    |> String.to_charlist
    |> Caesar.encrypt(shift)
    |> List.to_string
  end
  
  def rot13(string) do
    encrypt(string, 13)
  end
end

defimpl Caesar, for: List do
  def encrypt(list, shift) when is_integer(shift) and shift >= 0 do
    Enum.map(list, &shift_char(&1, shift))
  end

  defp shift_char(ch, n) when ch in ?a..?z do
    rem((ch - ?a + n), 26) + ?a
  end
  defp shift_char(ch, n) when ch in ?A..?Z do
    rem((ch - ?A + n), 26) + ?A
  end
  defp shift_char(ch, _), do: ch

  def rot13(list) do
    encrypt(list, 13)
  end
end

Enum.each ["asdf", 'asdf', 'abc', "{abc}", "ryvkve", 'zAA', [1,2,3]], fn value -> IO.puts "#{inspect value} -> #{inspect Caesar.encrypt(value, 1)}, #{inspect Caesar.rot13(value)}" end