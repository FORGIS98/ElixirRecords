defmodule ElixirrecordsWeb.RegistroController do
  use ElixirrecordsWeb, :controller
  alias Elixirrecords.Server, as: Server

  require Logger

  def login(conn, params) do

    if(!is_binary(params["email"])) do
      render(conn, "login.html")
    else
      res = Server.login(params["email"])
      case res do
        {:error, msg} ->
          conn
          |> put_flash(:error, msg)
          |> render("login.html")
        {:ok} ->
          res = Server.sendTx(params["email"])
          
          case res do
            {:error, msg} ->
              conn
              |> put_flash(:error, msg)
              |> render("login.html")
            {:ok, msg, tx_hash} ->
              conn
              |> put_flash(:ok, "This is your assistance hash: #{inspect tx_hash}")
              |> render("login.html")
          end
        {:admin} -> 
          conn
          |> render("admin.html")
      end     
    end
  end

  def registrarUsuario(conn, params) do
    if(!is_binary(params["email"])) do
      render(conn, "registrarUsuario.html")
    else
      if(checkUsername(params["email"], params["alias"])) do

        res = Server.registrar(params["email"], params["alias"])
        case res do
          {:error, msg} ->
            conn
            |> put_flash(:error, msg)
            |> render("registrarUsuario.html")
          {:ok} ->
            conn
            |> render("login.html")
        end

        render(conn, "registrarUsuario.html")
      else
        conn
        |> put_flash(:error, "Email or nickname not valid.")
        |> render("registrarUsuario.html")
      end
    end
  end

  defp checkUsername(email, name) do
    Regex.match?(~r/@alumnos.upm.es$/, email) and name != ""
  end

  def deploy(conn, params) do
    res = Server.deploy()

    case res do
      {:error, msg} ->
        conn
        |> put_flash(:error, msg)
        |> render("admin.html")
      {:ok, address} ->
        conn
        |> put_flash(:ok, "The deployed smart contract address is: #{inspect address}")
        |> render("admin.html")
    end
  end

end
