defmodule Actions.Chat.Mutation.SearchDocument do
  import Ecto.Query

  alias ExlChain.LLM
  alias ExlChain.LLM.OpenAI
  alias ExlChain.Index
  alias ExlChain.Index.Pinecone
  alias ExlChain.Template
  alias ExlChain.Chain
  alias Jehuty.Repo
  alias Schemas.Chat.Chunk
  alias Schemas.Chat.Story

  @input_limit 3000

  def run(_parent, args, context) do
    %{current_user: user} = context
    %{question: question, story_id: id} = args

    story = Repo.get_by!(Story, id: id, user_id: user.id)

    llm = OpenAI.new("text-embedding-ada-002")
    index = Pinecone.new(Application.get_env(:jehuty, :index_name))

    vector = LLM.call(llm, :embeddings, question)
    input_count = div(@input_limit, story.chunk_size)

    json = %{
      namespace: to_string(story.id),
      includeValues: false,
      includeMetadata: true,
      topK: (input_count * 2.2) |> floor,
      vector: vector
    }

    total_page_count =
      from(c in Chunk, where: c.story_id == ^story.id)
      |> Repo.aggregate(:count, :id)

    memories =
      Index.call(index, :query, json)
      |> Enum.sort(fn x, y ->
        x_score = adjust_score(x, total_page_count)
        y_score = adjust_score(y, total_page_count)
        x_score > y_score
      end)
      |> Enum.with_index()
      |> Enum.filter(fn {vector, i} ->
        IO.inspect(vector)
        i < input_count
      end)
      |> Enum.map(fn {vector, _i} ->
        Map.get(vector, "metadata", %{}) |> Map.get("chunk_id") |> String.to_integer()
      end)
      |> Enum.map(fn id ->
        Repo.get(Chunk, id)
      end)
      |> Enum.sort(fn x, y ->
        x.id < y.id
      end)
      |> Enum.map(fn chunk ->
        chunk.id |> IO.inspect()
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

  defp adjust_score(vector, total_page_count) do
    score = Map.get(vector, "score")
    [_, page_number] = Map.get(vector, "id") |> String.split("__")
    adjusted_value = 0.008 * Float.pow(0.94, total_page_count - String.to_integer(page_number))
    score + adjusted_value
  end
end
