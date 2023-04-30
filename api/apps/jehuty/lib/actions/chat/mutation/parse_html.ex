defmodule Actions.Chat.Mutation.ParseHtml do
  def run(_parent, args, _context) do
    %{url: _url} = args

    {:ok,
     %{
       document: 'document xxx'
     }}
  end
end
