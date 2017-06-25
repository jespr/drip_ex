defmodule Dripex do
  use HTTPoison.Base

  @moduledoc """
  A HTTP client for GetDrip
  """

  defmodule MissingApiTokenError do
    defexception message: """
    The API token is required so we can authenticate with the Drip API.
    """
  end

  defmodule MissingAccountIdError do
    defexception message: """
    The Drip account_id is required.
    """
  end

  def process_url(endpoint) do
    account_id = require_account_id()# |> Integer.to_string()
    "https://api.getdrip.com/v2/" <> account_id <> "/" <> endpoint
  end

  def process_response_body(body) do
    case body do
      "" ->
        %{}
      body ->
        body
        |> Poison.decode!
    end
  end

  def request_headers do
    Map.new
      |> Map.put("Content-Type", "application/vnd.api+json")
  end

  def make_request(method, endpoint, body \\ %{}, headers \\ %{}, options \\ []) do
    token = require_drip_api_token()
    auth = auth_header(token, "")

    b = Dripex.URI.encode_query(body)
    h = request_headers() 
      |> Map.merge(headers) 
      |> Map.to_list()

    {:ok, response} = request(method, endpoint, b, [auth | h], options) 
    %{ status_code: response.status_code, body: response.body}
  end

  defp require_account_id do
    case Application.get_env(:dripex, :account_id, System.get_env "DRIP_ACCOUNT_ID") || :not_found do
      :not_found ->
        raise MissingAccountIdError
      value -> value
    end
  end

  defp require_drip_api_token do
    case Application.get_env(:dripex, :api_token, System.get_env "DRIP_API_TOKEN") || :not_found do
      :not_found ->
        raise MissingApiTokenError
      value -> value
    end
  end

  def auth_header(username, password) do
    encoded = Base.encode64("#{username}:#{password}")
    {"Authorization", "Basic #{encoded}"}
  end

end
