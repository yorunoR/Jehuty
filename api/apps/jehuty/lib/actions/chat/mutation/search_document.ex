defmodule Actions.Chat.Mutation.SearchDocument do
  alias ExlChain.LLM
  alias ExlChain.LLM.OpenAI
  alias ExlChain.Index
  alias ExlChain.Index.Pinecone
  alias ExlChain.Template
  alias ExlChain.Chain
  alias Jehuty.Repo
  alias Schemas.Chat.Chunk
  alias Schemas.Chat.Story

  def run(_parent, args, context) do
    %{current_user: user} = context
    %{question: question, story_id: id} = args

    story = Repo.get_by!(Story, id: id, user_id: user.id)

    llm = OpenAI.new("text-embedding-ada-002")
    index = Pinecone.new(Application.get_env(:jehuty, :index_name))

    vector = LLM.call(llm, :embeddings, question)

    json = %{
      namespace: to_string(story.id),
      includeValues: false,
      includeMetadata: true,
      topK: div(3000, story.chunk_size),
      vector: vector
    }

    memories =
      Index.call(index, :query, json)
      |> Enum.map(fn vector ->
        IO.inspect(vector)
        Map.get(vector, "metadata", %{}) |> Map.get("chunk_id") |> String.to_integer()
      end)
      |> Enum.map(fn id ->
        Repo.get(Chunk, id)
      end)
      |> Enum.sort(fn x, y ->
        x.id < y.id
      end)
      |> Enum.map(fn chunk ->
        chunk.value |> IO.inspect()
      end)
      |> Enum.join("\n\n")

    chat_llm = OpenAI.new()
    params = %{"memories" => memories, "question" => question}

    template =
      Template.new(["memories", "question"], """
        物語の一部抜粋です。

        == ここから

        {memories}

        == ここまで


        以上を参考にし、次の質問に答えてください。

        {question}
      """)

    result =
      Chain.new(params)
      |> Chain.connect("answer", fn params ->
        LLM.call(chat_llm, :chat, template, params) |> IO.inspect()
      end)
      |> Chain.finish()

    {:ok,
     %{
       answer: result["answer"]
     }}
  end
end
