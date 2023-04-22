defmodule Graphql.Types.CustomObject.Answer do
  use Absinthe.Schema.Notation

  object :answer do
    field(:answer, :string)
  end
end
