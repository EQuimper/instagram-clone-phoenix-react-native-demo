defmodule Instagram.Repo.Migrations.CreatePhotoTags do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext"
    create table(:photo_tags) do
      add :name, :citext, null: false
    end

    create unique_index(:photo_tags, [:name])
  end
end
