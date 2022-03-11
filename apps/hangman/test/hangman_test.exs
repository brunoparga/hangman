defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "new game returns correct structure" do
    game = Hangman.Impl.Game.new_game("specify")

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters == ~w[s p e c i f y]
    assert Enum.all?(game.letters, fn letter -> letter =~ ~r/[a-z]/ end)
  end
end
