defmodule Dictionary do
  @moduledoc """
  The dictionary for a Hangman game.
  """

  alias Dictionary.Runtime.Server

  @opaque t :: Server.t()

  @spec start_link() :: {:error, any()} | {:ok, t()}
  defdelegate start_link, to: Server

  @spec random_word(pid()) :: String.t()
  defdelegate random_word(pid), to: Server
end
