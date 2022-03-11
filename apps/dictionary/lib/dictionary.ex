defmodule Dictionary do
  @moduledoc """
  The dictionary for a Hangman game.
  """

  @word_list "assets/words.txt"
             |> File.read!()
             |> String.split(~r/\n/, trim: true)

  def random_word do
    @word_list
    |> Enum.random()
  end
end
