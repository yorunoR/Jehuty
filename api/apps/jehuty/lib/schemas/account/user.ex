defmodule Schemas.Account.User do
  use Jehuty.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Chat.Chunk
  alias Schemas.Chat.History

  schema "users" do
    field :activated, :boolean
    field :email, :string
    field :name, :string
    field :profile_image, :string
    field :role, :integer
    field :uid, :string
    field :anonymous, :boolean

    timestamps()
    soft_delete_schema()

    has_many :histories, History, on_delete: :delete_all
    has_many :chunks, Chunk, on_delete: :delete_all
  end
end
