defmodule Resolvers.ChatResolver do
  alias Actions.Chat.Mutation
  alias Schemas.Account.User

  def call(action, parent, args, %{context: context}) do
    case Map.get(context, :current_user) do
      %User{} -> run(action, parent, args, context)
      _ -> {:error, :unauthenticated}
    end
  end

  def run(action, parent, args, context) do
    case action do
      :send_question ->
        Mutation.SendQuestion.run(parent, args, context)

      :save_history ->
        Mutation.SaveHistory.run(parent, args, context)

      :parse_html ->
        Mutation.ParseHtml.run(parent, args, context)

      :save_document ->
        Mutation.SaveDocument.run(parent, args, context)

      :search_document ->
        Mutation.SearchDocument.run(parent, args, context)

      _ ->
        {:error, "Not defined in Chat context"}
    end
  end
end
