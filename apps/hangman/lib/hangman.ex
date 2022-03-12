defmodule Hangman do
  alias Hangman.{Impl.Game, Type}
  @opaque game :: Game.t()

  @spec make_move(game, String.t()) :: {game, Type.tally()}
  defdelegate make_move(game, guess), to: Game

  @spec new_game() :: game
  defdelegate new_game, to: Game

  @spec tally(Game.t()) :: Type.tally()
  defdelegate tally(game), to: Game
end
