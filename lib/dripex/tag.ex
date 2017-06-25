defmodule Dripex.Tag do
  @moduledoc """
  Adds functionality for working with Tags through the Drip API.

  You can:
    
    * create a tag

  Drip API documentation: https://www.getdrip.com/docs/rest-api#tags
  """

  @endpoint "tags"

  def create(params) do
    params = %{tags: [params]}
    Dripex.make_request(:post, @endpoint, params)
      |> Dripex.Utils.handle_response()
  end
end
