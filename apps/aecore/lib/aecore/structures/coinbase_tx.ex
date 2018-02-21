defmodule Aecore.Structures.CoinbaseTx do
  @moduledoc """
  Aecore structure of a transaction data.
  """
  alias __MODULE__
  alias Aeutil.Serialization

  @type t :: %CoinbaseTx{
    to_acc: binary(),
    value: non_neg_integer(),
    lock_time_block: non_neg_integer()
  }

  @doc """
  Definition of Aecore CoinbaseTx structure

  ## Parameters
  - to_acc: To account is the public address of the account receiving the transaction
  - value: The amount of a transaction
  """
  defstruct [:to_acc, :value, :lock_time_block]
  use ExConstructor

  @spec create(binary(), non_neg_integer(), non_neg_integer()) :: {:ok, CoinbaseTx.t()}
  def create(to_acc, value, lock_time_block \\ 0) do
    %CoinbaseTx{to_acc: to_acc,
                value: value,
                lock_time_block: lock_time_block}
  end

  @spec hash_tx(CoinbaseTx.t()) :: binary()
  def hash_tx(tx) do
    :crypto.hash(:sha256, Serialization.pack_binary(tx))
  end

end
