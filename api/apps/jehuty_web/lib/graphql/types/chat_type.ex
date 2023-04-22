defmodule Graphql.Types.ChatType do
  use Absinthe.Schema.Notation

  alias Resolvers.ChatResolver

  object :chat_mutations do
    field(:send_question, non_null(:answer)) do
      arg(:question, non_null(:string))
      resolve(&ChatResolver.call(:send_question, &1, &2, &3))
    end

    field(:save_history, non_null(:history)) do
      arg(:history, non_null(:input_history))
      resolve(&ChatResolver.call(:save_history, &1, &2, &3))
    end
  end
end
