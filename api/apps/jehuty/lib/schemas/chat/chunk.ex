defmodule Schemas.Chat.Chunk do
  use Jehuty.Schema

  alias Schemas.Account.User
  alias Schemas.Chat.Story

  schema "chunks" do
    belongs_to :user, User
    belongs_to :story, Story

    field :vector_id, :string
    field :value, :string
    field :length, :integer
    field :embedding, Pgvector.Ecto.Vector
    field :page, :integer

    timestamps()
  end
end
