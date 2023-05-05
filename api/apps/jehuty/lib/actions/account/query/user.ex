defmodule Actions.Account.Query.User do
  alias Schemas.Account.User
  alias Jehuty.Repo

  def run(_parent, args, _context) do
    %{uid: uid} = args

    user = Repo.get_by(User, uid: uid)

    {:ok, user}
  end
end
