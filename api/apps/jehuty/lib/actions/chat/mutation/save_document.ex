defmodule Actions.Chat.Mutation.SaveDocument do
  import Ecto.Changeset

  alias ExlChain.LLM
  alias ExlChain.LLM.OpenAI
  alias ExlChain.Index
  alias ExlChain.Index.Pinecone
  alias Jehuty.Repo
  alias Poems.Scraper
  alias Poems.TextSplitter
  alias Schemas.Chat.Story

  @chunk_size 300

  def run(_parent, args, context) do
    %{current_user: user} = context
    %{url: url, document: document} = args

    title = get_title(url)

    story =
      %Story{
        title: title,
        user_id: user.id,
        chunk_size: @chunk_size
      }
      |> Repo.insert!()

    namespace = to_string(story.id)

    llm = OpenAI.new("text-embedding-ada-002")
    index = Pinecone.new(Application.get_env(:jehuty, :index_name))

    document
    |> TextSplitter.split_text(@chunk_size)
    |> Enum.with_index(1)
    |> Enum.each(fn {chunk, i} ->
      # to avoid access limit
      :timer.sleep(200)

      values = LLM.call(llm, :embeddings, chunk)
      vector_id = "#{namespace}__#{to_string(i)}"

      %{id: id} =
        story
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
        namespace: namespace
      }

      Index.call(index, :upsert, json)
    end)

    story
    |> change(status: :INDEXED)
    |> Repo.update!()

    {:ok,
     %{
       status: true
     }}
  end

  def get_title(url) do
    datetime =
      DateTime.utc_now()
      |> Calendar.strftime("_%y-%m-%d_%H:%M:%S")

    Scraper.run(url, "title")
    |> then(fn result ->
      case result do
        {:ok, title} ->
          title
          |> String.replace("\n", " ")
          |> String.trim()
          |> then(fn str ->
            str <> datetime
          end)

        _ ->
          "no tittle" <> datetime
      end
    end)
  end
end
