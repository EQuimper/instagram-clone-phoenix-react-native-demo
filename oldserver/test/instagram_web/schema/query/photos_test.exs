defmodule InstagramWeb.Schema.Query.PhotosTest do
  use InstagramWeb.ConnCase

  import Instagram.Factory

  @query """
  query ($limit: Int!, $offset: Int!) {
    photos(limit: $limit, offset: $offset) {
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

  @variables %{offset: 0, limit: 10}

  test "should return list of photos" do
    tags = insert_list(3, :tag)
    user = insert(:user)
    insert_list(20, :photo, user: user, tags: tags)

    response = get(build_conn(), "/api/graphql", query: @query, variables: @variables)
    assert %{"data" => %{
      "photos" => results
    }} = json_response(response, 200)

    assert length(results) == 10
    photo = hd(results)
    assert photo["id"] != nil
    assert photo["image_url"] != nil
    assert photo["user"] != nil
    assert photo["user"]["avatar"] != nil
    assert photo["user"]["username"] != nil
    assert photo["tags"] != nil
    assert length(photo["tags"]) == 3
    assert hd(photo["tags"])["name"] != nil
  end

end
