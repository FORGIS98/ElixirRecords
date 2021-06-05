defmodule ElixirrecordsWeb.RegistroController do
  use ElixirrecordsWeb, :controller
  alias Elixirrecords.Server, as: Server

  require Logger

  def registro(conn, params) do

    res = Server.sendTx(params["username"])
    IO.puts("El usuario es: #{inspect res}")
  

    # Llamar al backend (el back llama a la base de datos)
    # El backend firma y envia
    # Una vez finiquitao el front-end (este de aqui) renderiza la pagina de que todo guay :D
    render(conn, "registro.html")
  end
end
