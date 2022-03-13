defmodule Hangman.Impl.Game do
  #########################################################
  ####  ALIASES AND TYPES  ################################
  #########################################################

  alias Hangman.Type

  @type t :: %__MODULE__{
          turns_left: integer(),
          game_state: Type.state(),
          letters: list(String.t()),
          used: MapSet.t(String.t())
        }

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  #########################################################
  ####  PUBLIC INTERFACE  #################################
  #########################################################

  @spec make_move(t, String.t()) :: {t, Type.tally()}
  def make_move(game = %__MODULE__{game_state: state}, _guess)
      when state in [:won, :lost] do
    game
    |> return_with_tally()
  end

  def make_move(game, guess) do
    validate_guess(game, guess, guess =~ ~r/^[a-z]$/)
    |> return_with_tally()
  end

  #########################################################

  @spec new_game() :: t
  def new_game do
    new_game(Dictionary.random_word())
  end

  @spec new_game(String.t()) :: t
  def new_game(word) do
    %__MODULE__{
      letters: word |> String.graphemes()
    }
  end

  #########################################################

  @spec tally(t) :: Type.tally()
  def tally(game) do
    %{
      turns_left: game.turns_left,
      game_state: game.game_state,
      letters: reveal_guessed_letters(game),
      used: game.used |> MapSet.to_list() |> Enum.sort()
    }
  end

  #########################################################
  ####  PRIVATE FUNCTIONS #################################
  #########################################################

  @spec accept_guess(t, String.t(), boolean()) :: t
  defp accept_guess(game, _guess, _already_used = true) do
    %__MODULE__{game | game_state: :already_used}
  end

  defp accept_guess(game, guess, _already_used) do
    %__MODULE__{game | used: MapSet.put(game.used, guess)}
    |> score_guess(Enum.member?(game.letters, guess))
  end

  #########################################################

  @spec maybe_reveal(boolean(), String.t()) :: String.t()
  defp maybe_reveal(_good_letter = true, letter), do: letter
  defp maybe_reveal(_bad_letter, _letter), do: "_"

  #########################################################

  @spec maybe_won(boolean()) :: atom()
  defp maybe_won(true), do: :won
  defp maybe_won(_), do: :good_guess

  #########################################################

  @spec return_with_tally(t) :: {t, Type.tally()}
  defp return_with_tally(game), do: {game, tally(game)}

  #########################################################

  @spec reveal_guessed_letters(t) :: list(String.t())
  defp reveal_guessed_letters(%{game_state: :lost, letters: word}), do: word

  defp reveal_guessed_letters(game) do
    game.letters
    |> Enum.map(fn letter -> MapSet.member?(game.used, letter) |> maybe_reveal(letter) end)
  end

  #########################################################

  @spec score_guess(t, boolean()) :: t
  defp score_guess(game, _good_guess = true) do
    new_state = maybe_won(MapSet.subset?(MapSet.new(game.letters), game.used))
    %__MODULE__{game | game_state: new_state}
  end

  defp score_guess(game = %{turns_left: 1}, _bad_guess) do
    %__MODULE__{game | turns_left: 0, game_state: :lost}
  end

  defp score_guess(game, _bad_guess) do
    %__MODULE__{game | turns_left: game.turns_left - 1, game_state: :bad_guess}
  end

  #########################################################

  @spec validate_guess(t, String.t(), boolean()) :: t
  defp validate_guess(game, _guess, _valid_guess = false) do
    %__MODULE__{game | game_state: :invalid_guess}
  end

  defp validate_guess(game, guess, _valid_guess) do
    accept_guess(game, guess, MapSet.member?(game.used, guess))
  end
end
