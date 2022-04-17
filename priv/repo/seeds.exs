# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PaginateSample.Repo.insert!(%PaginateSample.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PaginateSample.Users

1..21
|> Enum.each(fn i ->
  Users.create_user(%{name: "user_#{i}"})
end)
