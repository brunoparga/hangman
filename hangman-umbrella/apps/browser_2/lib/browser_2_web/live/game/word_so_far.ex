defmodule Browser2Web.Live.Game.WordSoFar do
  use Browser2Web, :live_component

  @game_states %{
    initializing: {"initializing", "Guess the word, a letter at a time."},
    good_guess: {"good-guess", "Good guess!"},
    bad_guess: {"bad-guess", "Sorry, that letter is not in the word."},
    won: {"won", "You won!"},
    lost: {"lost", "Sorry, you lost..."},
    already_used: {"already-used", "You already used that letter."},
    invalid_guess: {"invalid-guess", "Please enter only one letter."}
  }

  defp display_state(state) do
    {_class, text} = @game_states[state]
    text
  end

  defp set_class("_"), do: ""
  defp set_class(_), do: " correct"
end
