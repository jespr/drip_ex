defmodule Dripex.Subscriber do
  @moduledoc """
  Adds functionality for working with Subscribers through the Drip API.

  You can:
    
    * create a subscriber


  Drip API documentation: https://www.getdrip.com/docs/rest-api#subscribers
  """

  @endpoint "subscribers"

  def create(params) do
    params = %{subscribers: [params]}
    Dripex.make_request(:post, @endpoint, params)
      |> Dripex.Utils.handle_response()
  end

  def get(id_or_email) do
    Dripex.make_request(:get, "#{@endpoint}/#{id_or_email}")
      |> Dripex.Utils.handle_response()
  end

  def all(params \\ %{}) do
    Dripex.make_request(:get, "#{@endpoint}", params)
      |> Dripex.Utils.handle_response()
  end
end
