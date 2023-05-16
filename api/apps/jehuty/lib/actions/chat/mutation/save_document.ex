defmodule Actions.Chat.Mutation.SaveDocument do
  import Ecto.Changeset

  alias ExlChain.LLM
  alias ExlChain.LLM.OpenAI
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

    llm = OpenAI.new("text-embedding-ada-002")

    document
    |> TextSplitter.split_text(@chunk_size)
    |> Enum.with_index(1)
    |> Enum.each(fn {chunk, i} ->
      # to avoid access limit
      :timer.sleep(200)

      values = LLM.call(llm, :embeddings, chunk)

      story
      |> Ecto.build_assoc(:chunks, %{
        value: chunk,
        length: String.length(chunk),
        embedding: values,
        page: i
      })
      |> Repo.insert!()
    end)

    story
    |> change(status: :INDEXED)
    |> Repo.update()
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
