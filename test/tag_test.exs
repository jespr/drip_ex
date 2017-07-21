defmodule Dripex.TagTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "create works" do
    use_cassette "dripex_test/tag/create", match_requests_on: [:query, :request_body] do
      {:ok, response} = Dripex.Tag.create(%{tag: "customer", email: "test@test.com"})

      assert response[:status_code] == 201
      assert response[:body] == %{}
    end
  end
end
