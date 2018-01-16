defmodule InstagramWeb.Schema.Mutation.DeletePhotoTest do
  use InstagramWeb.ConnCase

  import Instagram.Factory

  @query """
  mutation ($id: ID!) {
    deletePhoto(id: $id)
  }
  """

  test "should delete a photo if the user is the author" do
    user = insert(:user)
    photo = insert(:photo, user: user, tags: [])
    conn = build_conn() |> auth_user(user)

    response = post(conn, "/api/graphql", query: @query, variables: %{id: photo.id})

    assert %{"data" => %{
      "deletePhoto" => result
    }} = json_response(response, 200)

    assert result == "Successfully delete"

    photo = Instagram.Repo.get(Instagram.Posts.Photo, photo.id)

    assert photo == nil
  end

  test "should not allowed a user to delete a photo if this is not the author" do
    user = insert(:user)
    other_user = insert(:user)
    photo = insert(:photo, user: other_user, tags: [])
    conn = build_conn() |> auth_user(user)

    response = post(conn, "/api/graphql", query: @query, variables: %{id: photo.id})

    assert %{
      "data" => %{"deletePhoto" => nil},
      "errors" => [
        %{
          "locations" => [%{"column" => 0, "line" => 2}],
          "message" => "Cannot delete this photo",
          "path" => ["deletePhoto"]
        }
      ]
    } = json_response(response, 200)

    photo = Instagram.Repo.get(Instagram.Posts.Photo, photo.id)

    assert photo != nil
  end
end
