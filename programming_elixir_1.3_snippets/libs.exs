# pipe print helper
print = fn
  value, prefix when is_binary(value) -> IO.puts "#{prefix}: #{value}"
  value, prefix -> IO.puts "#{prefix}: #{inspect value}"
end

# format float as string with 2 decimal precision
:erlang.float_to_binary(1.2345, decimals: 2) |> print.("Float as formatted string")

# get system environment variables
System.get_pid() |> print.("PID")
System.put_env("newsystemvar", "test value")
System.get_env("newsystemvar") |> print.("Custom ENV value retrieved")
System.get_env("PATH") |> print.("System path")

# file extension
Path.extname("/test/path.ext") |> print.("File extension")

# current working directory
System.cwd |> print.("Current working directory")

# system shell command
System.cmd("echo", ["Hello World"]) |> print.("Result")