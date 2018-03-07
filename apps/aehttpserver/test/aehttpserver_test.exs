defmodule AehttpserverTest do
  use ExUnit.Case

  @tag :http_server
  test "Get candidate block, successfully" do
    {:ok, response} = HTTPoison.post("localhost:4000/get_candidate_block",
                                Poison.encode!(%{:pubkey => "test_key2"}),
                                               [{"Content-Type", "application/json"}])
    assert %{"status" => "ok"} = Poison.decode!(response.body)
  end

  @tag :http_server
  test "Get candidate block, failed" do
    {:ok, response} = HTTPoison.post("localhost:4000/get_candidate_block", "wrong input data")
    assert %{"status"   => "error",
             "response" => "Invalid input data"} = Poison.decode!(response.body)
  end
end
