
defmodule Aecore.Structures.SignedTx do
  @moduledoc """
  Aecore structure of a signed transaction.
  """

  alias Aecore.Keys.Worker, as: Keys
  alias Aecore.Structures.SpendTx
  alias Aecore.Structures.SignedTx
  alias Aeutil.Serialization

  @type t :: %SignedTx{
    data: SpendTx.t(),
    signature: binary()
  }

  @doc """
    Definition of Aecore SignedTx structure

  ## Parameters
     - data: Aecore %SpendTx{} structure
     - signature: Signed %SpendTx{} with the private key of the sender
  """
  defstruct [:data, :signature]
  use ExConstructor

  @spec is_valid?(SignedTx.t()) :: boolean()
  def is_valid?(tx) do
    tx.data.value >= 0 && tx.data.fee >= 0 && Keys.verify_tx(tx)
  end

  @spec is_signed_tx(map()) :: boolean()
  def is_signed_tx(tx) do
    Map.has_key?(tx, :data) && Map.has_key?(tx, :signature)
  end

  @spec hash_tx(SignedTx.t()) :: binary()
  def hash_tx(%SignedTx{data: data}) do
    :crypto.hash(:sha256, Serialization.pack_binary(data))
  end

end
