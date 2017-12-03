defmodule InstagramWeb.Schema.AccountsTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Instagram.Repo
  import Ecto.Query

  alias InstagramWeb.Resolvers

  object :user_session do
    field :token, non_null(:string)
  end

  object :user do
    field :email, non_null(:string)
    field :avatar, non_null(:string)
    field :username, non_null(:string)

    field :inserted_at, non_null(:string)
    field :updated_at, non_null(:string)
  end

  enum :provider do
    value :facebook
  end
end
