defmodule Elixirrecords.Server do
  alias Elixirrecords.Usuario, as: Usuario
  use GenServer

  # API
  def start_link(rpc) do
    GenServer.start_link(__MODULE__, rpc, name: __MODULE__)
  end

  def sendTx(usuario) do
    GenServer.call(__MODULE__, {:sendTx, usuario})
  end


  # GenServer Callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_call({:sendTx, usuario}, _from, state) do
    # mapa = Ecto.Repo.get_by!(Usuario, correo: usuario)
    IO.puts("El usuario es: #{inspect usuario}")
    {:reply, true, state}
  end

end
