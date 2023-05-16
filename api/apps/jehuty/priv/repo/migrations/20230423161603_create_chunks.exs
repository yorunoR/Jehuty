defmodule Jehuty.Repo.Migrations.CreateChunks do
  use Ecto.Migration

  def change do
    create table(:chunks) do
      add :vector_id, :string, null: true
      add :value, :text, null: false
      add :length, :integer, null: false
      add :story_id, references(:stories, on_delete: :nothing), null: true
      add :user_id, references(:users, on_delete: :nothing), null: true
      add :embedding, :vector, size: 1536
      add :page, :integer, null: true

      timestamps()
    end

    create index(:chunks, [:story_id])
  end
end
