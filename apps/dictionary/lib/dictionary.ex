defmodule Dictionary do
  @moduledoc """
  The dictionary for a Hangman game.
  """

  @spec random_word() :: String.t()
  defdelegate random_word(), to: Dictionary.Runtime.Server
end
