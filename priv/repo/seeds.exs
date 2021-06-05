# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Elixirrecords.Repo.insert!(%Elixirrecords.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Elixirrecords.Repo
alias Elixirrecords.{Usuario}

jorge = %Usuario{correo: "jorge@correo.com", nombre: "Jorge"} 
        |> Repo.insert!()
paula = %Usuario{correo: "paula@correo.com", nombre: "Paula"}
        |> Repo.insert!()
