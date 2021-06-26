defmodule ElixirrecordsWeb.Router do
  use ElixirrecordsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirrecordsWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/", PageController, :login

    get "/sign-up", PageController, :signUp
    post "/sign-up", PageController, :signUp

    post "/save-assistance", PageController, :saveAssistance

    get "/registro", RegistroController, :registrarUsuario
    post "/registro", RegistroController, :registrarUsuario

    get "/asistencia", RegistroController, :sendTx
    post "/asistencia", RegistroController, :sendTx

    get "/admin", RegistroController, :deploy
    post "/admin", RegistroController, :deploy
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirrecordsWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ElixirrecordsWeb.Telemetry
    end
  end
end
