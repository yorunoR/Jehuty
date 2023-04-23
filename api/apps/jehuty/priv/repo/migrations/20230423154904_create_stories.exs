defmodule Jehuty.Repo.Migrations.CreateStories do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def up do
    create table(:stories) do
      add :title, :string
      add :status, :integer, null: false, default: 0

      timestamps()
      soft_delete_columns()
    end
  end

  def down do
    drop table(:stories)
  end
end
