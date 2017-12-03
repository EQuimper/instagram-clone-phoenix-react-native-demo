defmodule Instagram.Repo.Migrations.CreatePostPhotoTaggings do
  use Ecto.Migration

  def change do
    create table(:photos_taggings, primary_key: false) do
      add :photo_id, references(:photos), null: false
      add :photo_tag_id, references(:photo_tags), null: false
    end
  end
end
