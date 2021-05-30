defmodule ElixirrecordsWeb.PageController do
  use ElixirrecordsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
