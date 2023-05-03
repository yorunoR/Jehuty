defmodule Graphql.Types.CustomObject.Document do
  use Absinthe.Schema.Notation

  object :document do
    field(:document, :string)
  end
end
