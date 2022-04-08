defmodule Browser2Web.Live.Game do
  use Browser2Web, :live_view

  def mount(_params, _session, socket) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    socket = socket |> assign(%{game: game, tally: tally})
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="game-holder">
      <%= live_component(__MODULE__.Figure, turns_left: assigns.tally.turns_left, id: "figure") %>
      <%= live_component(__MODULE__.Alphabet, used: assigns.tally.used, id: "alphabet") %>
      <%= live_component(__MODULE__.WordSoFar, word_so_far: assigns.tally.letters, id: 3) %>
    </div>
    """
  end
end
