defmodule Instagram.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :avatar, :string
      add :facebook_id, :string
      add :email, :string

      timestamps()
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:facebook_id])
    create unique_index(:users, [:email])
  end
end
