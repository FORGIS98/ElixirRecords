defmodule Elixirrecords.Repo.Migrations.CreateUsuarios do
  use Ecto.Migration

  def change do
    create table(:usuarios) do
      add :nombre, :string
      add :correo, :string

      timestamps()
    end

  end
end
