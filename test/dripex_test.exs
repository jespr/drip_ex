defmodule DripexTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Dripex

  # Token f4ff6a200e850131dca1040cce1ee51a
  # account_id 1430131

  test "process_url" do
    :ok = Application.put_env(:dripex, :account_id, "42")
    assert Dripex.process_url("subscribers") == "https://api.getdrip.com/v2/42/subscribers"
    :ok = Application.delete_env(:dripex, :account_id)
  end

  test "process_url without setting account_id in the config" do
    :ok = Application.put_env(:dripex, :account_id, nil)
    assert_raise Dripex.MissingAccountIdError, fn ->
      Dripex.process_url("subscribers")
    end
    :ok = Application.delete_env(:dripex, :account_id)
  end

  test "make_request for a successful request" do
    use_cassette "dripex_test/successful_request", match_requests_on: [:query, :request_body] do
      response = Dripex.make_request(:get, "campaigns")
        |> Dripex.Utils.handle_response()

      case response do
        {:ok, _} -> assert true
      end
    end
  end

  test "make_request for an invalid request" do
    use_cassette "dripex_test/error_request", match_requests_on: [:query, :request_body] do
      response = Dripex.make_request(:get, "subscribers/hello@example.com")
        |> Dripex.Utils.handle_response()

      case response do
        {:error, _} -> assert true
      end
    end
  end
end
