defmodule Actions.Chat.Mutation.SendQuestion do
  import Ecto.Query
  import Pgvector.Ecto.Query

  alias ExlChain.LLM
  alias ExlChain.LLM.OpenAI
  alias ExlChain.Template
  alias ExlChain.Chain
  alias Jehuty.Repo
  alias Schemas.Chat.Chunk

  def run(_parent, args, context) do
    %{current_user: user} = context
    %{question: question} = args

    llm = OpenAI.new("text-embedding-ada-002")
    vector = LLM.call(llm, :embeddings, question)

    query =
      from(c in Chunk,
        where: is_nil(c.story_id) and c.user_id == ^user.id,
        order_by: cosine_distance(c.embedding, ^vector),
        limit: 10
      )

    memories =
      query
      |> Repo.all()
      |> Enum.map(fn chunk ->
        chunk.value |> IO.inspect()
      end)
      |> Enum.join("\n")

    chat_llm = OpenAI.new()
    params = %{"memories" => memories, "question" => question}

    template =
      Template.new(["memories", "question"], """
        あなたと過去に次のような会話をしました。

        "Question:"以降の文が私、"Answer:"以降の文があなたの回答です。

        {memories}


        その上で次の質問に答えてください。回答の頭に"Answer:"をつける必要はありません。

        {question}
      """)

    result =
      Chain.new(params)
      |> Chain.connect("answer", fn params ->
        LLM.call(chat_llm, :chat, template, params)
      end)
      |> Chain.finish()

    {:ok,
     %{
       answer: result["answer"]
     }}
  end
end
