defmodule Elixirrecords.Server do
  alias Elixirrecords.Usuario, as: Usuario

  alias Elixirrecords.Repo, as: BD
  # alias Ethereumex.HttpClient, as: Eth
  alias ExW3.Contract, as: Contract
  use GenServer

  # API
  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def sendTx(usuario) do
    GenServer.call(__MODULE__, {:sendTx, usuario})
  end

  def deploy() do
    GenServer.call(__MODULE__, {:deploy})
  end

  def getEvents() do
    GenServer.call(__MODULE__, {:getEvents})
  end

  def registrar(email, nombre) do
    GenServer.call(__MODULE__, {:registrar, email, nombre})
  end


  # GenServer Callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_call({:registrar, email, nombre}, _from, state) do
      # Comprobamos que el usuario exista en la base de datos
      user = BD.get_by(Usuario, correo: email)
      if(user == nil) do
        %Usuario{correo: email, nombre: nombre}
        |> BD.insert!()

        {:reply, {:ok}, state}
      else
        {:reply, {:error, "El usuario ya existe en el sistema"}, state}
      end
  end

  def handle_call({:sendTx, mail}, _from, state) do
    # Comprobamos que se haya insertado algún correo
    if(mail != nil) do

      # Comprobamos que el usuario exista en la base de datos
      user = BD.get_by(Usuario, correo: mail)

      if(user != nil) do 
        {contract_abi, contractAddress} = state
        accounts = ExW3.accounts()

        # Instancia del smart contract
        ExW3.Contract.register(:ContratoAsistencia, abi: contract_abi)
        ExW3.Contract.at(:ContratoAsistencia, contractAddress)

        # Mandar la Tx
        {:ok, tx_hash} = ExW3.Contract.send(:ContratoAsistencia, :registrarAsistencia, [mail, to_string(DateTime.utc_now)], %{from: Enum.at(accounts, 2), gas: 32_000, gas_price: 0})

        {:reply, {:ok, "Transacción realizada", tx_hash}, state}
      else 
        {:reply, {:error, "Usuario no encontrado"}, state}
      end
    else 
      {:reply, {:wait, false}, state}
    end
  end # END - sendTx

  def handle_call({:deploy}, _from, state) do
    accounts = ExW3.accounts()
    contract_abi = ExW3.Abi.load_abi("priv/solidity/ContratoAsistencias_sol_ContratoAsistencias.abi")
    ExW3.Contract.register(:ContratoAsistencia, abi: contract_abi)
    deployAnswer = ExW3.Contract.deploy(:ContratoAsistencia, bin: ExW3.Abi.load_bin("priv/solidity/ContratoAsistencias_sol_ContratoAsistencias.bin"), options: %{gas: 300_000, gas_price: 0, from: Enum.at(accounts, 0)})

    case deployAnswer do
      {res, address, tx_hash} ->
        {:reply, {res, address}, {contract_abi, address}}
      {:error, msg} ->
        {:reply, {:error, msg}, state}
    end
  end

  def handle_call({:getEvents}, _from, state) do
    {contract_abi, contractAddress} = state

    # Instancia del smart contract
    ExW3.Contract.register(:ContratoAsistencia, abi: contract_abi)
    ExW3.Contract.at(:ContratoAsistencia, contractAddress)

    # Abrir filtro de eventos pasados
    {:ok, filtro} = ExW3.Contract.filter(:ContratoAsistencia, "Asistencia", %{fromBlock: 0, toBlock: "latest"})

    # Recuperar lista de asistentes hasta ahora
    {:ok, asistencias} = ExW3.Contract.get_filter_changes(filtro)

    # Cerrar filtro de eventos pasados
    ExW3.Contract.uninstall_filter(filtro)

    {:reply, {:ok, asistencias}, state}
  end

  
end
