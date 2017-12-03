defmodule InstagramWeb.Schema.Mutation.CreatePhotoTest do
  use InstagramWeb.ConnCase

  import Instagram.Factory

  @query """
  mutation ($imageUrl: String!, $tags: [String]!) {
    createPhoto(imageUrl: $imageUrl, tags: $tags) {
      id
      imageUrl
      tags {
        name
      }
      user {
        username
        avatar
      }
    }
  }
  """

  @variables %{imageUrl: "image", tags: ["hello"]}

  test "should create a photo with the argument user give" do
    user = insert(:user)
    conn = build_conn() |> auth_user(user)
    response = post(conn, "/api/graphql", query: @query, variables: @variables)
    assert %{"data" => %{
      "createPhoto" => result
    }} = json_response(response, 200)

    assert result != nil
    assert result["id"] != nil
    assert result["user"] != nil
    assert result["user"]["avatar"] != nil
    assert result["user"]["username"] != nil

    tag = hd(result["tags"])
    assert tag["name"] == "hello"

    assert result["imageUrl"] == @variables.imageUrl
  end

  test "should return unauthorized if no current_user" do
    response = post(build_conn(), "/api/graphql", query: @query, variables: @variables)
    assert %{
      "data" => %{"createPhoto" => nil},
      "errors" => [
        %{
          "locations" => [%{"column" => 0, "line" => 2}],
          "message" => "Unauthorized",
          "path" => ["createPhoto"]
        }
      ]
    } = json_response(response, 200)
  end
end
