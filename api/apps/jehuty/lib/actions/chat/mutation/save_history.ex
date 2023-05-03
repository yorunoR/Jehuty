defmodule Actions.Chat.Mutation.SaveHistory do
  import Ecto.Changeset

  alias ExlChain.LLM
  alias ExlChain.LLM.OpenAI
  alias ExlChain.Index
  alias ExlChain.Index.Pinecone
  alias Jehuty.Repo
  alias Schemas.Chat.History

  def run(_parent, args, context) do
    %{current_user: current_user} = context
    %{history: attrs} = args

    llm = OpenAI.new("text-embedding-ada-002")
    index = Pinecone.new(Application.get_env(:jehuty, :index_name))

    chunk = "Question: #{replace(attrs.question)}\nAnswer: #{replace(attrs.answer)}"
    values = LLM.call(llm, :embeddings, chunk)
    unix_time = DateTime.utc_now() |> DateTime.to_unix()
    vector_id = "#{current_user.uid}__#{to_string(unix_time)}"

    %{id: id} =
      current_user
      |> Ecto.build_assoc(:chunks, %{
        vector_id: vector_id,
        value: chunk,
        length: String.length(chunk)
      })
      |> Repo.insert!()

    json = %{
      vectors: %{
        id: vector_id,
        values: values,
        metadata: %{chunk_id: to_string(id)}
      },
      namespace: current_user.uid
    }

    Index.call(index, :upsert, json)

    %History{user: current_user}
    |> create_history_changeset(attrs)
    |> Repo.insert()
  end

  def create_history_changeset(%History{} = history, attrs) do
    history
    |> cast(attrs, [:question, :answer])
    |> validate_required([:question, :answer])
  end

  def replace(sentence) do
    String.replace(sentence, "\n", "")
  end
end
