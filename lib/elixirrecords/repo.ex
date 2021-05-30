defmodule Elixirrecords.Repo do
  use Ecto.Repo,
    otp_app: :elixirrecords,
    adapter: Ecto.Adapters.Postgres
end
