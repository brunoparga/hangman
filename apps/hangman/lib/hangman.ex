defmodule Hangman do
  alias Hangman.Impl.Game
  @opaque game :: Game.t()

  @spec make_move(game, String.t()) :: {game, Hangman.Type.tally()}
  defdelegate make_move(game, guess), to: Game

  @spec new_game() :: game
  defdelegate new_game, to: Game
end
