defmodule Schemas.Chat.History do
  use Jehuty.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.User

  schema "histories" do
    belongs_to :user, User

    field :answer, :string
    field :question, :string

    timestamps()
    soft_delete_schema()
  end
end
