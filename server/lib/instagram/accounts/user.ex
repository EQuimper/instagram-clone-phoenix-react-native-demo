defmodule Instagram.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :avatar, :string
    field :email, :string
    field :facebook_id, :string
    field :username, :string

    has_many :photos, Instagram.Posts.Photo

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:username, :avatar, :facebook_id, :email])
    |> validate_required([:avatar, :email])
    |> unique_constraint(:username)
    |> unique_constraint(:facebook_id)
    |> unique_constraint(:email)
  end
end
