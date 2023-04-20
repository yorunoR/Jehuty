defmodule Jehuty.Repo do
  use Ecto.Repo,
    otp_app: :jehuty,
    adapter: Ecto.Adapters.Postgres
end
