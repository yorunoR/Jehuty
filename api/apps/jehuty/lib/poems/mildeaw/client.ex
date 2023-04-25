defmodule Poems.Mildeaw.Client do
  defstruct [:url, :project_key, :api_key]

  alias __MODULE__

  def new do
    keyword = Application.get_env(:jehuty, :mildeaw)

    %Client{
      url: Keyword.get(keyword, :url),
      project_key: Keyword.get(keyword, :project_key),
      api_key: Keyword.get(keyword, :api_key)
    }
  end
end
