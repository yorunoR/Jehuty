defmodule Actions.Chat.Mutation.SaveDocument do
  def run(_parent, args, _context) do
    %{url: _url, document: _document} = args

    {:ok,
     %{
       status: true
     }}
  end
end
