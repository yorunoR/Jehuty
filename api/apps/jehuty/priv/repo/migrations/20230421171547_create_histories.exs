defmodule Jehuty.Repo.Migrations.CreateHistories do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def up do
    create table(:histories) do
      add :question, :text, null: false
      add :answer, :text, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
      soft_delete_columns()
    end

    create index(:histories, [:user_id])
  end

  def down do
    drop table(:histories)
  end
end
