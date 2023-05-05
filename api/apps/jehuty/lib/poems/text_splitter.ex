defmodule Poems.TextSplitter do
  def split_text(text, max_length) do
    text
    |> String.split("\n\n")
    |> Enum.reduce([], fn sentences, acc ->
      list = split_sentences(sentences, max_length)
      [list | acc]
    end)
    |> List.flatten()
    |> Enum.reverse()
  end

  def split_sentences(sentences, max_length) do
    sentences
    |> String.split("\n")
    |> Enum.reduce([], fn sentence, acc ->
      case acc do
        [] ->
          [sentence]

        [head | tail] ->
          case String.length(head) + String.length(sentence) < max_length do
            true ->
              [head <> sentence | tail]

            false ->
              [sentence | acc]
          end
      end
    end)
  end
end
