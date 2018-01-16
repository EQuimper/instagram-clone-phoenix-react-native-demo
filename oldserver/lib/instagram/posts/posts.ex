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

  def update_photo(args, user_id) do
    photo_id = Map.get(args, :id)
    query = from p in Photo, where: p.id == ^photo_id and p.user_id == ^user_id

    case Repo.one(query) do
      nil ->
        {:error, "Cannot update this photo"}
      photo ->
        photo
        |> Photo.changeset(args)
        |> Repo.update()
    end
  end

  def delete_photo(photo_id, user_id) do
    query = from p in Photo, where: p.id == ^photo_id and p.user_id == ^user_id

    case Repo.one(query) do
      nil ->
        {:error, "Cannot delete this photo"}
      photo ->
        Repo.delete(photo)
    end
  end

  def change_photo(%Photo{} = photo) do
    Photo.changeset(photo, %{})
  end

  def get_all_tags do
    Repo.all(PhotoTag)
  end

end
