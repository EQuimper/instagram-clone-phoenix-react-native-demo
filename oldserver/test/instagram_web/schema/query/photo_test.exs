defmodule InstagramWeb.Schema.Query.PhotoTest do
  use InstagramWeb.ConnCase

  import Instagram.Factory

  @query """
  query ($id: Int!) {
    photo(id: $id) {
      id
      image_url
      tags {
        name
      }
      user {
        avatar
        username
      }
    }
  }
  """

  test "should return the photo with the id provide" do
    user = insert(:user)
    tags = insert_list(2, :tag)
    photo = insert(:photo, user: user, tags: tags)

    response = get(build_conn(), "/api/graphql", query: @query, variables: %{id: photo.id})
    assert %{"data" => %{
      "photo" => result
    }} = json_response(response, 200)

    assert result["id"] == to_string(photo.id)
    [first_tag | [last_tag | _]] = result["tags"]
    assert first_tag["name"] != nil
    assert last_tag["name"] != nil
    assert result["image_url"] != nil

    assert result["user"] != nil
    assert result["user"]["avatar"] != nil
    assert result["user"]["username"] != nil
  end

  test "should return a error message if the photo don't exist" do
    response = get(build_conn(), "/api/graphql", query: @query, variables: %{id: 1})
    assert %{"data" => %{
      "photo" => photo
    }, "errors" => errors} = json_response(response, 200)

    assert photo == nil
    error = hd(errors)
    assert error["message"] == "Photo do not exist"
  end
end
