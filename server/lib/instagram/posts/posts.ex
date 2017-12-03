defmodule Instagram.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Instagram.Repo

  alias Instagram.Posts.{Photo, PhotoTag}

  def list_photos(limit, offset) do
    query = from p in Photo, order_by: [asc: :inserted_at], limit: ^limit, offset: ^offset
    Repo.all(query)
  end

  def get_photo(id), do: Repo.get(Photo, id)

  def create_photo(attrs \\ %{}) do
    %Photo{}
    |> Photo.changeset(attrs)
    |> Repo.insert()
  end

  def update_photo(%Photo{} = photo, attrs) do
    photo
    |> Photo.changeset(attrs)
    |> Repo.update()
  end

  def delete_photo(%Photo{} = photo) do
    Repo.delete(photo)
  end

  def change_photo(%Photo{} = photo) do
    Photo.changeset(photo, %{})
  end

  def get_all_tags do
    Repo.all(PhotoTag)
  end

end
