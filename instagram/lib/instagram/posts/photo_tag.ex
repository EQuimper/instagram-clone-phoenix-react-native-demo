defmodule Instagram.Posts.PhotoTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photo_tags" do
    field :name, :string

    many_to_many :photos, Instagram.Posts.Photo, join_through: "photos_taggings"
  end

  @doc false
  def changeset(%__MODULE__{} = photo_tag, attrs) do
    photo_tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
