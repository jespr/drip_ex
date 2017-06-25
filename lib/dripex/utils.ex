defmodule Dripex.Utils do
  def handle_response(response) do
    cond do
      response.body["errors"] -> {:error, response}
      response -> {:ok, response}
    end
  end
end
