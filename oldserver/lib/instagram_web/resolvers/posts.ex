defmodule InstagramWeb.Resolvers.Posts do
  def get_photo(_, %{id: id}, _) do
    case Instagram.Posts.get_photo(id) do
      nil ->
        {:error, "Photo do not exist"}
      photo ->
        {:ok, photo}
    end
  end

  def list_photos(_, %{offset: offset, limit: limit}, _) do
    {:ok, Instagram.Posts.list_photos(limit, offset)}
  end

  def create_photo(_, args, %{context: %{current_user: current_user}}) do
    args = Map.merge(args, %{user_id: current_user.id})
    with {:ok, photo} <- Instagram.Posts.create_photo(args) do
      {:ok, photo}
    end
  end

  def delete_photo(_, %{id: id}, %{context: %{current_user: current_user}}) do
    case Instagram.Posts.delete_photo(id, current_user.id) do
      {:error, error_message} ->
        {:error, error_message}
      {:ok, _} ->
        {:ok, "Successfully delete"}
    end
  end

  def update_photo(_, args, %{context: %{current_user: current_user}}) do
    case Instagram.Posts.update_photo(args, current_user.id) do
      {:error, error_message} ->
        {:error, error_message}
      {:ok, photo} ->
        {:ok, photo}
    end
  end

  def get_all_tags(_, _, _) do
    {:ok, Instagram.Posts.get_all_tags()}
  end
end
