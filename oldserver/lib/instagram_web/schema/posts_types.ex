defmodule InstagramWeb.Schema.PostsTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Instagram.Repo
  import Ecto.Query

  alias InstagramWeb.Resolvers

  object :photo do
    field :id, non_null(:id)
    field :image_url, non_null(:string)
    field :caption, :string
    field :tags, non_null(list_of(:tag)), resolve: assoc(:tags)
    field :user, non_null(:user), resolve: assoc(:user)

    field :inserted_at, non_null(:string)
    field :updated_at, non_null(:string)
  end

  object :tag do
    field :id, non_null(:id)
    field :name, non_null(:string)
  end
end
