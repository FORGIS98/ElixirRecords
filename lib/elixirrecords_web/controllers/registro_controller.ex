defmodule ElixirrecordsWeb.RegistroController do
  use ElixirrecordsWeb, :controller
  alias Elixirrecords.Server, as: Server

  require Logger

  def registro(conn, params) do
    res = Server.sendTx(params["username"])
    case res do
      {val, value} ->
        IO.puts("Val es: #{inspect val}")
        IO.puts("Value es: #{inspect value}")
      true ->
        IO.puts("Respuesta: true")
      false ->
        IO.puts("Respuesta: false")
      default ->
        IO.puts("Respuesta: #{inspect default}")
    end

    # Llamar al backend (el back llama a la base de datos)
    # El backend firma y envia
    # Una vez finiquitao el front-end (este de aqui) renderiza la pagina de que todo guay :D
    render(conn, "registro.html")
  end
end
