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

%Usuario{correo: "jorge@alumnos.upm.es", nombre: "Jorge"} |> Repo.insert!()
%Usuario{correo: "paula@alumnos.upm.es", nombre: "Paula"} |> Repo.insert!()
%Usuario{correo: "admin@correo.com", nombre: "Admin"} |> Repo.insert!()