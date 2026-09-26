defmodule BankAccount do
  use GenServer

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank account, making it available for further operations.
  """
  @spec open() :: account
  def open() do
    {:ok, account} = GenServer.start_link(__MODULE__, 0)
    account
  end

  @doc """
  Close the bank account, making it unavailable for further operations.
  """
  @spec close(account) :: any
  def close(account) do
    GenServer.call(account, :close)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account) do
    GenServer.call(account, :balance)
  end

  @doc """
  Add the given amount to the account's balance.
  """
  @spec deposit(account, integer) :: :ok | {:error, :account_closed | :amount_must_be_positive}
  def deposit(account, amount) do
    GenServer.call(account, {:deposit, amount})
  end

  @doc """
  Subtract the given amount from the account's balance.
  """
  @spec withdraw(account, integer) ::
          :ok | {:error, :account_closed | :amount_must_be_positive | :not_enough_balance}
  def withdraw(account, amount) do
    GenServer.call(account, {:withdraw, amount})
  end

  @impl GenServer
  def init(balance), do: {:ok, %{balance: balance, closed?: false}}

  @impl GenServer
  def handle_call(:close, _from, state), do: {:reply, :ok, %{state | closed?: true}}

  def handle_call(:balance, _from, %{closed?: true} = state),
    do: {:reply, {:error, :account_closed}, state}

  def handle_call(:balance, _from, state), do: {:reply, state.balance, state}

  def handle_call({:deposit, _amount}, _from, %{closed?: true} = state),
    do: {:reply, {:error, :account_closed}, state}

  def handle_call({:deposit, amount}, _from, state) when amount <= 0,
    do: {:reply, {:error, :amount_must_be_positive}, state}

  def handle_call({:deposit, amount}, _from, state),
    do: {:reply, :ok, %{state | balance: state.balance + amount}}

  def handle_call({:withdraw, _amount}, _from, %{closed?: true} = state),
    do: {:reply, {:error, :account_closed}, state}

  def handle_call({:withdraw, amount}, _from, state) when amount <= 0,
    do: {:reply, {:error, :amount_must_be_positive}, state}

  def handle_call({:withdraw, amount}, _from, state) when amount > state.balance,
    do: {:reply, {:error, :not_enough_balance}, state}

  def handle_call({:withdraw, amount}, _from, state),
    do: {:reply, :ok, %{state | balance: state.balance - amount}}
end
