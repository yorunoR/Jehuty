defmodule Graphql.Types.InputObject.InputHistory do
  use Absinthe.Schema.Notation

  input_object :input_history do
    field(:question, non_null(:string))
    field(:answer, non_null(:string))
  end
end
