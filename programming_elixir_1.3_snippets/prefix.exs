prefix = fn pre ->
  fn val ->
    "#{pre} #{val}"
  end
end

mrs = prefix.("Mrs")
IO.puts mrs.("Smith")
IO.puts prefix.("Elixer").("Rocks")