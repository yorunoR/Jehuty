defmodule Actions.Chat.Mutation.SendQuestion do
  alias ExlChain.LLM
  alias ExlChain.LLM.OpenAI
  alias ExlChain.Index
  alias ExlChain.Index.Pinecone
  alias ExlChain.Template
  alias ExlChain.Chain
  alias Jehuty.Repo
  alias Schemas.Chat.Chunk

  def run(_parent, args, context) do
    %{current_user: current_user} = context
    %{question: question} = args

    llm = OpenAI.new("text-embedding-ada-002")
    index = Pinecone.new("stories")

    vector = LLM.call(llm, :embeddings, question)

    json = %{
      namespace: current_user.uid,
      includeValues: false,
      includeMetadata: true,
      topK: 10,
      vector: vector
    }

    memories =
      Index.call(index, :query, json)
      |> Enum.map(fn vector ->
        Map.get(vector, "metadata", %{}) |> Map.get("chunk_id") |> String.to_integer()
      end)
      |> Enum.map(fn id ->
        chunk = Repo.get(Chunk, id)
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
