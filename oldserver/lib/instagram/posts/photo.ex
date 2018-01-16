defmodule Instagram.Posts.Photo do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Instagram.Posts.PhotoTag
  alias Instagram.Repo

  schema "photos" do
    field :image_url, :string
    field :caption, :string

    belongs_to :user, Instagram.Accounts.User

    many_to_many :tags, PhotoTag, join_through: "photos_taggings"

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = photo, attrs) do
    photo
    |> cast(attrs, [:image_url, :caption, :user_id])
    |> validate_required([:image_url, :user_id])
    |> put_assoc(:tags, parse_tags(attrs))
  end

  defp parse_tags(params) do
    (params.tags || [])
    |> Enum.map(&String.trim/1)
    |> Enum.reject(& &1 == "")
    |> insert_and_get_all()
  end

  defp insert_and_get_all([]) do
    []
  end

  defp insert_and_get_all(names) do
    maps = Enum.map(names, &%{name: &1})
    Repo.insert_all(PhotoTag, maps, on_conflict: :nothing)
    Repo.all(from t in PhotoTag, where: t.name in ^names)
  end

end
