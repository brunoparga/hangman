defmodule TextClient.Impl.Player do
  #########################################################
  ####  ALIASES AND TYPES  ################################
  #########################################################

  @typep server :: Hangman.server()
  @typep tally :: Hangman.Type.tally()
  @typep state :: {server, tally}

  #########################################################
  ####  PUBLIC INTERFACE  #################################
  #########################################################

  @spec start(server) :: :ok
  def start(server) do
    tally = Hangman.tally(server)
    interact({server, tally})
  end

  #########################################################
  ####  PRIVATE FUNCTIONS #################################  #########################################################

  @spec current_word(tally) :: list(String.t())
  defp current_word(%{letters: word, turns_left: turns, used: used}) do
    [
      "\nTurns left: ",
      turns |> to_string(),
      "\nLetters used so far: ",
      used |> Enum.join(", "),
      "\nWord so far: ",
      word |> Enum.join(" ")
    ]
  end

  #########################################################

  @spec feedback_for(tally()) :: String.t()
  defp feedback_for(%{game_state: :initializing, letters: word}) do
    "Welcome! I'm thinking of a #{word |> length}-letter word."
  end

  defp feedback_for(%{game_state: :good_guess}), do: "Good guess!"
  defp feedback_for(%{game_state: :bad_guess}), do: "Sorry, that letter is not in the word."
  defp feedback_for(%{game_state: :already_used}), do: "You already used that letter."

  defp feedback_for(%{game_state: :invalid_guess}) do
    "Invalid guess. Please insert only one letter from A to Z."
  end

  #########################################################

  @spec get_guess() :: String.t()
  defp get_guess do
    IO.gets("\nNext letter: ")
    |> String.trim()
    |> String.downcase()
  end

  #########################################################

  @spec interact(state) :: :ok
  defp interact({_game, %{game_state: :won}}), do: IO.puts("Congratulations. You won!")

  defp interact({_game, %{game_state: :lost, letters: word}}) do
    IO.puts("Sorry, you lost. The word was '#{word |> Enum.join()}'.")
  end

  defp interact({game, tally}) do
    IO.puts(feedback_for(tally))
    IO.puts(current_word(tally))

    tally = Hangman.make_move(game, get_guess())
    interact({game, tally})
  end
end
