defmodule InstagramWeb.Schema do
  use Absinthe.Schema

  import_types __MODULE__.PostsTypes
  import_types __MODULE__.AccountsTypes

  alias InstagramWeb.Resolvers
  alias InstagramWeb.Schema.Middleware

  query do
    @desc "Get a photo by id"
    field :photo, :photo do
      arg :id, non_null(:id)
      resolve &Resolvers.Posts.get_photo/3
    end

    @desc "Get all photos with a limit and offset"
    field :photos, list_of(:photo) do
      arg :limit, non_null(:integer)
      arg :offset, non_null(:integer)
      resolve &Resolvers.Posts.list_photos/3
    end

    @desc "Get all tags"
    field :tags, list_of(:tag) do
      resolve &Resolvers.Posts.get_all_tags/3
    end
  end

  mutation do
    @desc "Create a photo"
    field :create_photo, :photo do
      arg :image_url, non_null(:string)
      arg :tags, non_null(list_of(:string))
      middleware Middleware.Authorize
      resolve &Resolvers.Posts.create_photo/3
    end

    @desc "Login as a user"
    field :login, :user_session do
      arg :token, :string
      arg :provider, type: :provider
      resolve &Resolvers.Accounts.login/3
    end
  end

end
