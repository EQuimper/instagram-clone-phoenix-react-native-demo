defmodule Instagram.Factory do
  use ExMachina.Ecto, repo: Instagram.Repo

  alias Instagram.{Accounts, Posts}

  @doc """
  Helper for setting up a conn with a current_user
  """
  def auth_user(conn, user) do
    {:ok, token, _} = InstagramWeb.Auth.Guardian.encode_and_sign(user)
    conn
    |> Plug.Conn.put_req_header("authorization", "Bearer #{token}")
  end

  def user_factory do
    %Accounts.User{
      username: Faker.Internet.user_name(),
      email: Faker.Internet.email(),
      avatar: Faker.Internet.image_url()
    }
  end

  def user_factory(:user, attrs) do
    %Accounts.User{
      username: attrs.username,
      email: Faker.Internet.email(),
      avatar: Faker.Internet.image_url()
    }
  end

  def tag_factory do
    %Posts.PhotoTag{
      name: Faker.Pokemon.name()
    }
  end

  def photo_factory do
    %Posts.Photo{
      image_url: Faker.Internet.image_url(),
      user: build(:user),
      tags: [build(:tag)]
    }
  end
end
