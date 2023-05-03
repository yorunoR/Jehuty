defmodule Schemas.Chat.Story do
  use Jehuty.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.User
  alias Schemas.Chat.Chunk

  schema "stories" do
    belongs_to :user, User

    field :status, Ecto.Enum, values: [CREATED: 0, INDEXED: 1]
    field :title, :string
    field :chunk_size, :integer

    timestamps()
    soft_delete_schema()

    has_many :chunks, Chunk, on_delete: :delete_all
  end
end
