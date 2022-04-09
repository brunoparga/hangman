defmodule Browser2Web.Live.Game.Alphabet do
  use Browser2Web, :live_component

  def mount(socket) do
    letters = ~w|a b c d e f g h i j k l m n o p q r s t u v w x y z|
    {:ok, assign(socket, :letters, letters)}
  end

  def render(assigns) do
    ~H"""
    <div class="alphabet">
    <%= for letter <- assigns.letters do %>
      <div
        phx-click="make_move"
        phx-value-key={letter}
        class={"one-letter" <> set_class(letter, @tally)}
      >
      <%= letter %>
      </div>
    <% end %>
    </div>
    """
  end

  defp set_class(letter, tally) do
    cond do
      Enum.member?(tally.letters, letter) ->
        " correct"

      Enum.member?(tally.used, letter) ->
        " wrong"

      true ->
        ""
    end
  end
end
