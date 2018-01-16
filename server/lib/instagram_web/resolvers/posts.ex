defmodule InstagramWeb.Resolvers.Posts do
  def photos(_, _, _) do
    {:ok, Instagram.Posts.list_photos}
  end
end