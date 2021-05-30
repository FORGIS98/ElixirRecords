defmodule ElixirrecordsWeb.RegistroController do
  use ElixirrecordsWeb, :controller

  require Logger

  def registro(conn, params) do
    Logger.debug("CONN: #{inspect conn}")
    Logger.debug("PARAMS: #{inspect params}")
    render(conn, "registro.html")
  end
end
