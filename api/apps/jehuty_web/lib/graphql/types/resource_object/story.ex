defmodule Graphql.Types.ResourceObject.Story do
  use Absinthe.Schema.Notation

  object :story do
    field(:id, non_null(:id))
    field(:status, non_null(:string))
    field(:title, non_null(:string))
    field(:chunk_size, non_null(:integer))
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))
  end
end
