defmodule Graphql.Types.ResourceObject.History do
  use Absinthe.Schema.Notation

  object :history do
    field(:id, non_null(:id))
    field(:answer, non_null(:string))
    field(:question, non_null(:string))
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))
  end
end
