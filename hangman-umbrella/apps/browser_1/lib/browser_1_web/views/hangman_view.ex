defmodule Browser1Web.HangmanView do
  use Browser1Web, :view

  @status_fields %{
    initializing: {"initializing", "Guess the word, a letter at a time"},
    good_guess: {"good-guess", "Good guess!"},
    bad_guess: {"bad-guess", "Sorry, that's a bad guess"},
    won: {"won", "You won!"},
    lost: {"lost", "Sorry, you lost"},
    already_used: {"already-used", "You already used that letter"},
    invalid_guess: {"invalid-guess", "Please enter only one letter"}
  }

  def move_status(status) do
    {class, msg} = @status_fields[status]
    "<div class='status #{class}'>#{msg}</div>"
  end

  def continue_or_try_again(conn, state) when state in [:won, :lost] do
    button("Try again", to: Routes.hangman_path(conn, :new))
  end

  def continue_or_try_again(conn, _) do
    form_for(conn, Routes.hangman_path(conn, :update), [as: "make_move", method: :put], fn f ->
      [
        text_input(f, :guess),
        " ",
        submit("Make next guess")
      ]
    end)
  end

  defdelegate figure_for(turns_left), to: Browser1Web.HangmanView.Helpers.FigureFor
end
