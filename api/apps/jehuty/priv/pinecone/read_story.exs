import Ecto.Changeset

alias ExlChain.LLM
alias ExlChain.LLM.OpenAI
alias ExlChain.Index
alias ExlChain.Index.Pinecone
alias Jehuty.Repo
alias Schemas.Chat.Story

{keywords, [filename]} =
  System.argv()
  |> OptionParser.parse!(
    aliases: [
      s: :separator,
      t: :title
    ],
    strict: [
      separator: :string,
      title: :string
    ]
  )

separator = Keyword.get(keywords, :separator) |> String.replace("\\n", "\n")
title = Keyword.get(keywords, :title)

proc = fn ()->
  chunks =
    File.read!(filename)
    |> String.split(separator)
    |> Enum.map(fn chunk -> String.replace(chunk, "\n", "") end)

  llm = OpenAI.new("text-embedding-ada-002")
  index = Pinecone.new("stories")

  story = %Story{title: title} |> Repo.insert!

  chunks
  |> Enum.with_index(1)
  |> Enum.each(fn {chunk, i} ->
    # to avoid access limit
    :timer.sleep(200)

    values = LLM.call(llm, :embeddings, chunk)
    vector_id = "#{title}__#{to_string(i)}"

    %{id: id} =
      story
      |> Ecto.build_assoc(:chunks, %{
        vector_id: vector_id,
        value: chunk,
        length: String.length(chunk)
      })
      |> Repo.insert!

    json = %{
      vectors: %{
        id: vector_id,
        values: values,
        metadata: %{chunk_id: to_string(id)}
      },
      namespace: title
    }

    Index.call(index, :upsert, json)
  end)

  story
  |> change(status: :INDEXED)
  |> Repo.update
end

proc.()
