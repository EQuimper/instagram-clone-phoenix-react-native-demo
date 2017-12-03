defmodule InstagramWeb.Schema.Mutation.UpdateUserTest do
  use InstagramWeb.ConnCase

  import Instagram.Factory

  @query """
  mutation ($username: String!) {
    updateUser(username: $username) {
      username
      email
    }
  }
  """

  @variables %{username: "jonsnow"}

  test "should update the user with the args provided" do
    user = insert(:user)
    conn = build_conn() |> auth_user(user)
    response = post(conn, "/api/graphql", query: @query, variables: @variables)
    assert %{"data" => %{
      "updateUser" => result
    }} = json_response(response, 200)

    assert result["email"] == user.email
    assert result["username"] == @variables.username
  end

  test "should return unauthorized if no current_user" do
    response = post(build_conn(), "/api/graphql", query: @query, variables: @variables)
    assert %{
      "data" => %{"updateUser" => nil},
      "errors" => [
        %{
          "locations" => [%{"column" => 0, "line" => 2}],
          "message" => "Unauthorized",
          "path" => ["updateUser"]
        }
      ]
    } = json_response(response, 200)
  end

  test "should return an error if update username and this username is already taken" do
    insert(:user, %{username: "jonsnow"})
    user2 = insert(:user)
    conn = build_conn() |> auth_user(user2)
    response = post(conn, "/api/graphql", query: @query, variables: @variables)
    assert %{
      "data" => %{"updateUser" => nil},
      "errors" => [
        %{
          "locations" => [%{"column" => 0, "line" => 2}],
          "message" => "username has already been taken",
          "path" => ["updateUser"]
        }
      ]
    } = json_response(response, 200)
  end
end
