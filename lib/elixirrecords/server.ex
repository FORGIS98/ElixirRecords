defmodule Elixirrecords.Server do
  alias Elixirrecords.Usuario, as: Usuario
  alias Elixirrecords.Repo, as: BD
  # alias Ethereumex.HttpClient, as: Eth
  alias ExW3.Contract, as: Contract
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

      # Comprobamos que el usuario exista en la base de datos
      user = BD.get_by(Usuario, correo: mail)
  
      if(user != nil) do 

        # Construir parametros de la Tx
        
        # accounts = ExW3.accounts()
        {:ok, address} = ExW3.personal_new_account("elixir")
        {:ok, true} = ExW3.personal_unlock_account([address, "elixir", 30], [])

        contract_abi = ExW3.Abi.load_abi("priv/solidity/ContratoAsistencias_sol_ContratoAsistencias.abi")
        ExW3.Contract.register(:ContratoAsistencia, abi: contract_abi)
        {res, address, tx_hash} = ExW3.Contract.deploy(:ContratoAsistencia, bin: ExW3.Abi.load_bin("priv/solidity/ContratoAsistencias_sol_ContratoAsistencias.bin"), options: %{gas: 300_000, from: address})

        IO.puts("res: #{inspect res}")
        IO.puts("address: #{inspect address}")
        IO.puts("tx_hash: #{inspect tx_hash}")

        # ExW3.Contract.at(:SimpleStorage, address)
        # {:ok, tx} = ExW3.Contract.send(:SimpleStorage, :set, [1], %{from: address, gas: 50_000})


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
