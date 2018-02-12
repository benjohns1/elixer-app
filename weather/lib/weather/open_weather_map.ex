defmodule Weather.OpenWeatherMap do
  require Logger
  @user_agent [ {"User-agent", "Elixir weather app"} ]
  @api_key Application.get_env(:weather, :open_weather_map_api_key)

  def fetch(city) do
    "https://api.openweathermap.org/data/2.5/weather?q=#{city}&APPID=#{@api_key}&mode=xml&units=imperial"
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def handle_response({ :ok, %{status_code: 200, body: body}}) do
    Logger.info "Successful response"
    Logger.debug fn -> inspect(body) end
    {:ok, body}
  end

  def handle_response({ _, %{status_code: status, body: body}}) do
    Logger.error "Error #{status} returned"
    {:error, body}
  end

end