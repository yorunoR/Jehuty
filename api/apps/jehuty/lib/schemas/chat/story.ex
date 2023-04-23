defmodule Schemas.Chat.Story do
  use Jehuty.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Chat.Chunk

  schema "stories" do
    field :status, Ecto.Enum, values: [CREATED: 0, INDEXED: 1]
    field :title, :string

    timestamps()
    soft_delete_schema()

    has_many :chunks, Chunk, on_delete: :delete_all
  end
end
