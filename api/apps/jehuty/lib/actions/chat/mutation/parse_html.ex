defmodule Actions.Chat.Mutation.ParseHtml do
  alias Poems.Scraper

  def run(_parent, args, _context) do
    %{url: url, selector: selector} = args

    {:ok, document} = Scraper.run(url, selector)

    {:ok,
     %{
       document: document
     }}
  end
end
