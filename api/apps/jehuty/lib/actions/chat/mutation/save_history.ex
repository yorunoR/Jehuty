defmodule Actions.Chat.Mutation.SaveHistory do
  import Ecto.Changeset

  alias Jehuty.Repo
  alias Schemas.Chat.History

  def run(_parent, args, context) do
    %{current_user: current_user} = context
    %{history: attrs} = args

    %History{user: current_user}
    |> create_history_changeset(attrs)
    |> Repo.insert()
  end

  def create_history_changeset(%History{} = history, attrs) do
    history
    |> cast(attrs, [:question, :answer])
    |> validate_required([:question, :answer])
  end
end
