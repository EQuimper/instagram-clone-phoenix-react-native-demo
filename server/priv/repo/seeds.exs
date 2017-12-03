import Integer, only: [is_odd: 1]

alias Instagram.{Posts, Repo, Accounts}

number_of_mock_photos = 20
number_of_mock_tags = 20
number_of_mock_users = 5

tag_name = Enum.map(1..number_of_mock_tags, &("name#{&1}"))

# Users
for idx <- 1..number_of_mock_users do
  sex = if (is_odd(idx)), do: "men", else: "women"
  avatar = "https://randomuser.me/api/portraits/#{sex}/#{idx}.jpg"
  %Accounts.User{
    email: Faker.Internet.email(),
    username: Faker.Internet.user_name(),
    avatar: avatar
  }
  |> Repo.insert!
end

# Photos
for _ <- 1..number_of_mock_photos do
  photo = %{
    image_url: Faker.Internet.image_url(),
    tags: Enum.take_random(tag_name, Enum.random(1..4)),
    user_id: Enum.random(1..number_of_mock_users)
  }

  %Posts.Photo{}
  |> Posts.Photo.changeset(photo)
  |> Repo.insert!
end
