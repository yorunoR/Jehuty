defmodule Actions.Chat.Mutation.SendQuestion do
  alias ExlChain.LLM
  alias ExlChain.LLM.OpenAI

  def run(_parent, args, _context) do
    %{question: question} = args

    answer = OpenAI.new() |> LLM.call(:chat, question)

    {:ok,
     %{
       answer: answer
     }}
  end
end
