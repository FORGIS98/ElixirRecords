defmodule ElixirrecordsWeb.RegistroController do
  use ElixirrecordsWeb, :controller
  alias Elixirrecords.Server, as: Server

  require Logger

  def registro(conn, params) do
    res = Server.sendTx(params["username"])
    case res do
      {:error, msg} ->
        conn
        |> put_flash(:error, msg)
        |> render("registro.html")
      {:wait, msg} ->
        render(conn, "registro.html")
      {:ok, msg} ->
        render(conn, "registrado.html")
    end
    # Llamar al backend (el back llama a la base de datos)
    # El backend firma y envia
    # Una vez finiquitao el front-end (este de aqui) renderiza la pagina de que todo guay :D
  end
end
