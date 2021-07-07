defmodule ElixirrecordsWeb.PageController do
  use ElixirrecordsWeb, :controller

  alias Elixirrecords.Server, as: Server

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def login(conn, params) do
    res = Server.login(params["username"], params["password"])
    case res do
      {:error, msg} ->
        conn |> put_flash(:error, msg) |> render("index.html")
      {:ok} ->
        put_session(conn, :user_logged_in, params["username"])
        |> events(nil)
      {:admin} ->
        put_session(conn, :user_logged_in, "admin")
        |> events(nil)
    end
  end 

  def signUp(conn, params) do
    if(Map.has_key?(params, "re_password")) do
      %{"nickname" => nickname, "email" => email, "password" => pass, "re_password" => repass} = params
      cond do
        Regex.match?(~r/@| /, nickname) -> 
          conn |> put_flash(:error, "Nickname not valid, @ and space are not allowed.") |> render("signup.html")

        !Regex.match?(~r/@/, email) -> 
          conn |> put_flash(:error, "Email not valid") |> render("signup.html")

        String.length(pass) < 8 -> 
          conn |> put_flash(:error, "Password min length is 8") |> render("signup.html")

        pass != repass -> 
          conn |> put_flash(:error, "Passwords don't match") |> render("signup.html")

        true ->
          res = Server.signup(nickname, email, pass)
          case res do
            {:error, msg} ->
              conn |> put_flash(:error, msg) |> render("signup.html")
            {:ok} ->
              render(conn, "index.html")
          end
      end
    else
        render(conn, "signup.html")
    end
  end

  def events(conn, params) do
    res = Server.getEvents()
    case res do 
      {:error, msg} ->
        conn |> put_flash(:error, msg) |> render("index.html")
      {:ok, events} ->
        render(conn, "events.html", events: events)
    end
  end

  def saveAssistance(conn, params) do
    # TODO: This goes with admin
    # Server.deploy()
    res = Server.sendTx(params["eventName"], get_session(conn, :user_logged_in))

    # TODO: render a popup with a "OK", or some feedback
    events(conn, params)
  end
end
