defmodule Elixirrecords.Server do
  alias Elixirrecords.Usuario, as: Usuario
  alias Elixirrecords.Repo, as: BD
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


  def handle_call({:sendTx, mail}, _from, state) do

    # Comprobamos que se haya insertado algún correo
    if(mail != nil) do

      # Comprobamos ese usuario exista en la base de datos
      user = BD.get_by(Usuario, correo: mail)
  
      if(user != nil) do 

        # Construir parametros de la Tx

        # Firmal la Tx

        # Mandar la Tx

        {:reply, {:ok, "Transacción realizada"}, state}
      
      else 
        {:reply, {:error, "Usuario no encontrado"}, state}

      end

    else 
      {:reply, {:wait, false}, state}

    end
  
  end

end
