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

    field(:parse_html, non_null(:document)) do
      arg(:url, non_null(:string))
      resolve(&ChatResolver.call(:parse_html, &1, &2, &3))
    end

    field(:save_document, non_null(:status)) do
      arg(:url, non_null(:string))
      arg(:document, non_null(:string))
      resolve(&ChatResolver.call(:save_document, &1, &2, &3))
    end
  end
end
