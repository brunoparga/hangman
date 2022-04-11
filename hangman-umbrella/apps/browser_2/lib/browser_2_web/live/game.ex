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
    <div class="game-holder" phx-window-keyup="make_move">
      <%= live_component(__MODULE__.Figure, turns_left: assigns.tally.turns_left, id: "figure") %>
      <div class="right-side-components">
        <%= live_component(__MODULE__.Alphabet, tally: assigns.tally, id: "alphabet") %>
        <%= live_component(__MODULE__.WordSoFar, tally: assigns.tally, id: "word_so_far") %>
      </div>
    </div>
    """
  end

  def handle_event("make_move", %{"key" => key}, socket) do
    tally = Hangman.make_move(socket.assigns.game, key)
    {:noreply, assign(socket, :tally, tally)}
  end
end
