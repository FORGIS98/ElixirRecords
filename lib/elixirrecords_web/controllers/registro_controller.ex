defmodule ElixirrecordsWeb.RegistroController do
  use ElixirrecordsWeb, :controller
  alias Elixirrecords.Server, as: Server

  require Logger


  def registrarUsuario(conn, params) do

    if(!is_binary(params["email"])) do
      render(conn, "registrarUsuario.html")
    else
      if(checkUsername(params["email"])) do

        res = Server.registrar(params["email"])
        case res do
          {:error, msg} ->
            conn
            |> put_flash(:emailError, msg)
            |> render("registrarUsuario.html")
          {:ok} ->
            conn
            |> render("evento.html")
        end

        render(conn, "registrarUsuario.html")
      else
        conn
        |> put_flash(:emailError, "Email no valido")
        |> render("registrarUsuario.html")
      end
    end
  end

  defp checkUsername(user) do
    is_binary(user) and Regex.match?(~r/@alumnos.upm.es$/, user)
  end

  def sendTx(conn, params) do
    res = Server.sendTx(params["username"])
    case res do
      {:error, msg} ->
        conn
        |> put_flash(:error, msg)
        |> render("evento.html")
      {:wait, msg} ->
        render(conn, "evento.html")
      {:ok, msg, tx_hash} ->
        IO.puts("El hash es: #{inspect tx_hash}")
        render(conn, "registrado.html")
    end
  end

end
