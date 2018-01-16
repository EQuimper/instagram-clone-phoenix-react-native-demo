defmodule Instagram.PostsTest do
  use Instagram.DataCase

  import Instagram.Factory

  alias Instagram.Posts

  describe "photos" do
    alias Instagram.Posts.Photo

    @valid_attrs %{image_url: "some image_url", tags: ["hello", "world"]}
    @update_attrs %{image_url: "some updated image_url"}
    @invalid_attrs %{image_url: nil, tags: nil}

    def photo_fixture do
      user = insert(:user)
      tags = insert_list(3, :tag)
      {user, tags}
    end

    test "list_photos/2 returns a certains number of photos" do
      {user, tags} = photo_fixture()
      insert_list(10, :photo, tags: tags, user: user)
      photos = Posts.list_photos(10, 0)
      assert length(photos) == 10
    end

    test "get_photo!/1 returns the photo with given id" do
      {user, _} = photo_fixture()
      photo = insert(:photo, user: user)
      photo_saved = Posts.get_photo(photo.id)
      assert photo_saved.id == photo.id
    end

    test "create_photo/1 with valid data creates a photo" do
      {user, _} = photo_fixture()
      args = Map.merge(@valid_attrs, %{user_id: user.id})
      assert {:ok, %Photo{} = photo} = Posts.create_photo(args)
      assert photo.image_url == "some image_url"
      assert hd(photo.tags).name == "hello"
      assert photo.user_id == user.id
    end

    test "create_photo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_photo(@invalid_attrs)
    end

    test "update_photo/2 with valid data updates the photo" do
      {user, tags} = photo_fixture()
      photo = insert(:photo, tags: tags, user: user)
      tags = Enum.map(tags, &(&1.name))
      args = Map.merge(@update_attrs, %{tags: tags})
      IO.inspect [args: args]
      assert {:ok, photo} = Posts.update_photo(photo, args, user.id)
      IO.inspect [photo: photo]
      assert %Photo{} = photo
      assert photo.image_url == "some updated image_url"
    end

    # test "update_photo/2 with invalid data returns error changeset" do
    #   {user, tags} = photo_fixture()
    #   photo = insert(:photo, user: user, tags: tags)
    #   tags = Enum.map(tags, &(&1.name))
    #   args = Map.merge(@invalid_attrs, %{tags: tags})
    #   assert {:error, %Ecto.Changeset{}} = Posts.update_photo(photo, args)
    #   assert photo.id == Posts.get_photo(photo.id).id
    #   assert photo.image_url == Posts.get_photo(photo.id).image_url
    # end

    # test "delete_photo/1 deletes the photo" do
    #   photo = photo_fixture()
    #   assert {:ok, %Photo{}} = Posts.delete_photo(photo)
    #   assert_raise Ecto.NoResultsError, fn -> Posts.get_photo!(photo.id) end
    # end

    # test "change_photo/1 returns a photo changeset" do
    #   photo = photo_fixture()
    #   assert %Ecto.Changeset{} = Posts.change_photo(photo)
    # end
  end
end
