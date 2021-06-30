defmodule Elixirrecords.Server do
  alias Elixirrecords.User, as: User
  alias Elixirrecords.Event, as: Event
  alias Elixirrecords.Repo, as: DB
  use GenServer

  # API
  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def login(username, password) do
    GenServer.call(__MODULE__, {:login, username, password})
  end

  def signup(nickname, email, password) do
    GenServer.call(__MODULE__, {:signup, nickname, email, password})
  end

  def getEvents() do
    GenServer.call(__MODULE__, {:getEvents})
  end

  def sendTx(eventName, username) do
    GenServer.call(__MODULE__, {:sendTx, eventName, username})
  end

  def deploy() do
    GenServer.call(__MODULE__, {:deploy})
  end

  def getAssistances() do
    GenServer.call(__MODULE__, {:getAssistances})
  end


  # GenServer Callbacks
  def init(_) do
    {:ok, nil}
  end

  def handle_call({:login, username, password}, _from, state) do
    user = fetch_user(username, password)
    if(user != nil) do
      if(user.nickname == "hackerman" or user.email == "hackerman@email.com") do
        {:reply, {:admin}, state}
      else
        {:reply, {:ok}, state}
      end
    else
      {:reply, {:error, "Ups, we can't find you :("}, state}
    end
  end

  def handle_call({:signup, nickname, email, password}, _from, state) do
    user = fetch_user(nickname)

    if(user != nil) do
      {:reply, {:error, "There is already a user with that nickname"}, state}
    end

    %User{nickname: nickname, email: email, password: password} |> DB.insert!()
    {:reply, {:ok}, state}
  end

  def handle_call({:getEvents}, _from, state) do
    all_events = DB.all(Event)
    if(all_events != nil) do
      {:reply, {:ok, all_events}, state}
    else
      {:reply, {:error, "There are no events available now, try in the future."}, state}
    end
  end

  def handle_call({:sendTx, eventName, username}, _from, state) do
  end

#  def handle_call({:sendTx, eventName, username}, _from, state) do
#    user = fetch_user(username)
#
#    if(state == nil) do
#      {:reply, {:error, "Ask your admin to deploy the Smart Contract."}, state}
#    else
#      if(user != nil) do 
#        {contract_abi, contractAddress} = state
#        accounts = ExW3.accounts()
#
#        # Instancia del smart contract
#        ExW3.Contract.register(:ContratoAsistencia, abi: contract_abi)
#        ExW3.Contract.at(:ContratoAsistencia, contractAddress)
#
#        # Mandar la Tx
#        {:ok, tx_hash} = ExW3.Contract.send(:ContratoAsistencia, :registrarAsistencia, [username, to_string(DateTime.utc_now)], %{from: Enum.at(accounts, 2), gas: 32_000, gas_price: 0})
#
#        {:reply, {:ok, "Transaction completed!", tx_hash}, state}
#      else 
#        {:reply, {:error, "User not found"}, state}
#      end
#    end
#  end
#
#  def handle_call({:deploy}, _from, state) do
#    accounts = ExW3.accounts()
#    contract_abi = ExW3.Abi.load_abi("priv/solidity/ContratoAsistencias_sol_ContratoAsistencias.abi")
#    ExW3.Contract.register(:ContratoAsistencia, abi: contract_abi)
#    deployAnswer = ExW3.Contract.deploy(:ContratoAsistencia, bin: ExW3.Abi.load_bin("priv/solidity/ContratoAsistencias_sol_ContratoAsistencias.bin"), options: %{gas: 300_000, gas_price: 0, from: Enum.at(accounts, 0)})
#    case deployAnswer do
#      {_, address, _} ->
#        {:reply, {:ok, address}, {contract_abi, address}}
#      {:error, msg} ->
#        {:reply, {:error, msg}, state}
#    end
#  end
#
#  def handle_call({:getAssistances}, _from, state) do
#    {contract_abi, contractAddress} = state
#
#    # Instancia del smart contract
#    ExW3.Contract.register(:ContratoAsistencia, abi: contract_abi)
#    ExW3.Contract.at(:ContratoAsistencia, contractAddress)
#
#    # Abrir filtro de eventos pasados
#    {:ok, filtro} = ExW3.Contract.filter(:ContratoAsistencia, "Asistencia", %{fromBlock: 0, toBlock: "latest"})
#
#    # Recuperar lista de asistentes hasta ahora
#    {:ok, asistencias} = ExW3.Contract.get_filter_changes(filtro)
#
#    # Cerrar filtro de eventos pasados
#    ExW3.Contract.uninstall_filter(filtro)
#
#    {:reply, {:ok, asistencias}, state}
#  end

  ### Private methods to support GenServer Callbacks
  
  defp fetch_user(username, password) do
    if(Regex.match?(~r/@/, username)) do
      # Login using user email
      DB.get_by(User, [email: username, password: password])
    else
      # Login using user nickname
      DB.get_by(User, [nickname: username, password: password])
    end
  end 

  defp fetch_user(username) do
    DB.get_by(User, nickname: username)
  end 
end
