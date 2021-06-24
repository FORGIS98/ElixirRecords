defmodule ElixirrecordsWeb.PageController do
  use ElixirrecordsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def login(conn, params) do
    res = Server.login(params["username"], params["password"])
    case res do
      {:error, msg} ->
        conn |> put_flash(:error, msg) |> render("index.html")
      {:ok} ->
        render(conn, "events.html")
      {:admin} ->
        render(conn, "admin.html")
    end
  end # END - login
end
