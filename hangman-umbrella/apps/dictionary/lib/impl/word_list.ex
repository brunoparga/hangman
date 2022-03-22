defmodule Dictionary.Impl.WordList do
  @type t :: list(String.t())

  def word_list do
    "/home/bruno/code/learn/coding-gnome/hangman-umbrella/apps/dictionary/assets/words.txt"
    |> File.read!()
    |> String.split(~r/\n/, trim: true)
  end

  def random_word(word_list) do
    word_list
    |> Enum.random()
  end
end
