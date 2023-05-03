defmodule Jehuty.Repo.Migrations.CreateStories do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def up do
    create table(:stories) do
      add :title, :string
      add :status, :integer, null: false, default: 0
      add :chunk_size, :integer, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
      soft_delete_columns()
    end

    create index(:stories, [:user_id])
  end

  def down do
    drop table(:stories)
  end
end
