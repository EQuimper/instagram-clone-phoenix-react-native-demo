defmodule InstagramWeb.Schema.AccountsTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Instagram.Repo
  import Ecto.Query

  alias InstagramWeb.Resolvers

  object :user_session do
    field :token, non_null(:string)
    field :user, :user
  end

  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :avatar, non_null(:string)
    field :username, :string

    field :inserted_at, non_null(:string)
    field :updated_at, non_null(:string)
  end

  enum :provider do
    value :facebook
  end
end
