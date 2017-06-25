defmodule Dripex.SubscriberTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "create works" do
    use_cassette "dripex_test/subscribers/create", match_requests_on: [:query, :request_body] do
      {:ok, response} = Dripex.Subscriber.create(%{email: "test@test.com"})

      subscriber = response[:body]["subscribers"]
        |> List.first

      assert subscriber["email"] == "test@test.com"
    end
  end

  test "get works" do

    use_cassette "dripex_test/subscribers/create", match_requests_on: [:query, :request_body] do
      {:ok, response} = Dripex.Subscriber.create(%{email: "test@test.com"})
    end

    use_cassette "dripex_test/subscribers/get", match_requests_on: [:query, :request_body] do
      {:ok, response} = Dripex.Subscriber.get("test@test.com")

      subscriber = response[:body]["subscribers"]
        |> List.first
      assert subscriber["email"] == "test@test.com"
    end
  end

  test "all works" do

    use_cassette "dripex_test/subscribers/create_two", match_requests_on: [:query, :request_body] do
      {:ok, response} = Dripex.Subscriber.create(%{email: "test@test.com"})
      {:ok, response} = Dripex.Subscriber.create(%{email: "test2@test.com"})
    end

    use_cassette "dripex_test/subscribers/all", match_requests_on: [:query, :request_body] do
      {:ok, response} = Dripex.Subscriber.all()

      subscriber_count = response[:body]["subscribers"]
        |> Kernel.length
      assert subscriber_count == 2
    end
  end

end
