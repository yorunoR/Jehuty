# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Jehuty.Repo.insert!(%Jehuty.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Jehuty.Admin

Admin.register_admin_user(%{email: "sss.yoshioka@gmail.com", password: "123456123456"})
