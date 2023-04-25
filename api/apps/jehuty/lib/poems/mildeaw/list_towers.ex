defmodule Poems.Mildeaw.ListTowers do
  alias Poems.Mildeaw

  def run(client, variables) do
    query = """
      query ProjectTowers {
        currentProject {
          id
          name
          towers {
            id
            name
          }
        }
      }
    """

    Mildeaw.query(client, query, variables)
  end
end
