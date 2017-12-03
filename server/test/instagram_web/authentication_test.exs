defmodule InstagramWeb.AuthenticationTest do
  use InstagramWeb.ConnCase, async: true

  alias InstagramWeb.Authentication

  # expires 16-01-2018
  @facebook_token "EAAT2DOau9awBAA7oOy6197z3yAx4dZCsed1qEtWp0kfmGdxZA31ZCl4URWBMRyBaYo3sNcMJ6cL53fHOSLPODb13RNx5yafY8ZBYqHcCJAJJpv3XWIvG7klOo4HxpYLsekZAqrwee34B1ZBN97q1Nr0f6YzIDo0pAZCJQ8bdNogawZDZD"

  test "Authentication.login/2 should return a user when log with facebook" do
    {:ok, user} = Authentication.login(@facebook_token, "facebook")

    assert user != nil
    assert user.email != nil
    assert user.avatar != nil
    assert user.facebook_id != nil
  end
end
