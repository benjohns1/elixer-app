defmodule Weather.CLI do
  @moduledoc """
  Documentation for Weather.
  """

  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlAttribute, Record.extract(:xmlAttribute, from_lib: "xmerl/include/xmerl.hrl")

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.
  Otherwise it is the city name for which to retrieve weather data.
  Return a tuple of `{ city }`, or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv,
      switches: [ help: :boolean ],
      aliases:  [ h:    :help    ])
    case parse do
      { [ help: true ], _, _ }  -> :help
      { _, [ city ], _ }        -> { city }
      _                         -> :help
    end
  end


  def process(:help) do
    IO.puts """
    usage: weather <city>
    """
    System.halt(0)
  end

  def process({city}) do
    Weather.OpenWeatherMap.fetch(city)
    |> parse_xml
    |> decode_xml_response
    |> display_weather
  end

  def display_weather(weather_data) do
    IO.puts "City: " <> weather_data[:city]
    IO.puts "Sunrise: " <> weather_data[:sunrise]
    IO.puts "Sunset: " <> weather_data[:sunset]
    IO.puts "Current temperature: " <> weather_data[:temp] <> " degrees F"
  end
  
  def parse_xml({status, xml_binary}) do
    {xml_struct, _} = xml_binary |> :binary.bin_to_list |> :xmerl_scan.string
    {status, xml_struct}
  end

  def decode_xml_response({:ok, xmerl_struct}) do
    [city_attr] = :xmerl_xpath.string('/current/city/@name', xmerl_struct)
    city_val = xmlAttribute(city_attr, :value) |> to_string
    [sunrise_attr] = :xmerl_xpath.string('/current/city/sun/@rise', xmerl_struct)
    sunrise_val = xmlAttribute(sunrise_attr, :value) |> to_string
    [sunset_attr] = :xmerl_xpath.string('/current/city/sun/@set', xmerl_struct)
    sunset_val = xmlAttribute(sunset_attr, :value) |> to_string
    [temp_attr] = :xmerl_xpath.string('/current/temperature/@value', xmerl_struct)
    temp_val = xmlAttribute(temp_attr, :value) |> to_string

    [city: city_val, sunrise: sunrise_val, sunset: sunset_val, temp: temp_val]
  end

  def decode_xml_response({:error, _}) do
    IO.puts "Error fetching weather data from API"
    System.halt(2)
  end

end
