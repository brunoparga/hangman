defmodule Dictionary do
  @moduledoc """
  The dictionary for a Hangman game.
  """

  alias Dictionary.Impl.WordList
  @opaque t :: WordList.t()

  @spec start() :: t
  defdelegate start, to: WordList, as: :word_list

  @spec random_word(list(String.t())) :: String.t()
  defdelegate random_word(word_list), to: WordList
end
