defmodule Elixirrecords.Usuario do
  use Ecto.Schema
  import Ecto.Changeset

  schema "usuarios" do
    field :correo, :string
    field :nombre, :string

    timestamps()
  end

  @doc false
  def changeset(usuario, attrs) do
    usuario
    |> cast(attrs, [:nombre, :correo])
    |> validate_required([:nombre, :correo])
  end
end
