defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  alias Hangman.Impl.Game

  test "new_game returns correct structure" do
    game = Game.new_game("specify")

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters == ~w[s p e c i f y]
    assert Enum.all?(game.letters, fn letter -> letter =~ ~r/[a-z]/ end)
  end

  test "state doesn't change if a game is won or lost" do
    for state <- [:won, :lost] do
      game = Hangman.new_game() |> Map.put(:game_state, state)
      {new_game, _tally} = Hangman.make_move(game, "a")

      assert new_game == game
    end
  end

  test "a duplicate letter is reported" do
    game = Game.new_game()
    game = Map.put(game, :used, MapSet.put(game.used, "x"))
    assert game.game_state != :already_used

    {game, _tally} = Hangman.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "played letters are recorded" do
    game = Game.new_game()
    {game, _tally} = Hangman.make_move(game, "y")
    {game, _tally} = Hangman.make_move(game, "x")

    assert game.used == MapSet.new(["x", "y"])
  end

  test "recognize a letter in the word" do
    game = Game.new_game("testing")
    {game, tally} = Game.make_move(game, "g")
    assert tally.game_state == :good_guess

    {_game, tally} = Game.make_move(game, "n")
    assert tally.game_state == :good_guess
  end

  test "identify a winning move" do
    game = Game.new_game("toe")
    {game, tally} = Game.make_move(game, "t")
    assert tally.game_state == :good_guess

    {game, tally} = Game.make_move(game, "e")
    assert tally.game_state == :good_guess

    {_game, tally} = Game.make_move(game, "o")
    assert tally.game_state == :won
  end

  test "recognize a letter that is not in the word" do
    game = Game.new_game("testing")
    {game, tally} = Game.make_move(game, "h")
    assert tally.game_state == :bad_guess

    game = %Game{game | turns_left: 1}
    {_game, tally} = Game.make_move(game, "x")
    assert tally.game_state == :lost
  end

  test "handle a sequence of moves" do
    [
      # guess | state, turns left, letters, used
      ["a", :bad_guess, 6, ~w/_ _ _ _ _/, ~w/a/],
      ["e", :good_guess, 6, ~w/_ e _ _ _/, ~w/a e/],
      ["x", :bad_guess, 5, ~w/_ e _ _ _/, ~w/a e x/],
      ["m", :bad_guess, 4, ~w/_ e _ _ _/, ~w/a e m x/],
      ["t", :bad_guess, 3, ~w/_ e _ _ _/, ~w/a e m t x/]
    ]
    |> test_sequence_of_moves()
  end

  defp test_sequence_of_moves(script) do
    game = Game.new_game("hello")
    Enum.reduce(script, game, &check_one_move/2)
  end

  defp check_one_move([guess, state, turns, letters, used], game) do
    {game, tally} = Game.make_move(game, guess)

    assert tally.game_state == state
    assert tally.turns_left == turns
    assert tally.letters == letters
    assert tally.used == used

    game
  end
end
