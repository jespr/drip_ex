defmodule Dripex.EventTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "create works" do
    use_cassette "dripex_test/event/create", match_requests_on: [:query, :request_body] do
      {:ok, response} = Dripex.Event.create(%{action: "baked a cookie", email: "test@test.com"})

      assert response[:status_code] == 204
      assert response[:body] == %{}
    end
  end
end
