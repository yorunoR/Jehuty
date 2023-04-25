defmodule Poems.Mildeaw do
  alias Poems.Mildeaw.Client
  alias Poems.Mildeaw.ListTowers

  def call(client, request, variables \\ []) do
    case request do
      :list_towers ->
        ListTowers.run(client, variables)

      _ ->
        {:error, "Undefined mildeaw request"}
    end
  end

  def query(%Client{} = client, query, variables) do
    GQL.query(
      query,
      url: client.url,
      headers: [
        {"X-Mildeaw-Project-Key", client.project_key},
        {"X-Mildeaw-Api-Key", client.api_key}
      ],
      variables: variables
    )
  end

  def mutation(%Client{} = client, mutation, variables) do
    GQL.query(
      mutation,
      url: client.url,
      headers: [
        {"X-Mildeaw-Project-Key", client.project_key},
        {"X-Mildeaw-Api-Key", client.api_key}
      ],
      variables: variables
    )
  end

  def subscription(%Client{} = client, subscription, variables) do
    GQL.query(
      subscription,
      url: client.url,
      headers: [
        {"X-Mildeaw-Project-Key", client.project_key},
        {"X-Mildeaw-Api-Key", client.api_key}
      ],
      variables: variables
    )
  end
end
