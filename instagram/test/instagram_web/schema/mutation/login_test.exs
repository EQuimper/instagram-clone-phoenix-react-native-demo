defmodule InstagramWeb.Schema.Mutation.LoginTest do
  use InstagramWeb.ConnCase

  @query """
  mutation ($provider: Provider, $token: String!) {
    login(provider: $provider, token: $token) {
      token
    }
  }
  """

  @token "EAAT2DOau9awBAA7oOy6197z3yAx4dZCsed1qEtWp0kfmGdxZA31ZCl4URWBMRyBaYo3sNcMJ6cL53fHOSLPODb13RNx5yafY8ZBYqHcCJAJJpv3XWIvG7klOo4HxpYLsekZAqrwee34B1ZBN97q1Nr0f6YzIDo0pAZCJQ8bdNogawZDZD"

  @variables %{"provider" => "FACEBOOK", "token" => @token}

  test "should log a user and return a token" do
    response = post(build_conn(), "/api/graphql", query: @query, variables: @variables)
    assert %{"data" => %{
      "login" => %{
        "token" => result
      }
    }} = json_response(response, 200)

    assert result != nil
  end
end
