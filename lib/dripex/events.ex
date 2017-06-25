defmodule Dripex.Event do
  @moduledoc """
  Adds functionality for working with Events through the Drip API.

  You can:
    
    * create an event

  Drip API documentation: https://www.getdrip.com/docs/rest-api#events
  """

  @endpoint "events"

  def create(params) do
    params = %{events: [params]}
    Dripex.make_request(:post, @endpoint, params)
      |> Dripex.Utils.handle_response()
  end
end
