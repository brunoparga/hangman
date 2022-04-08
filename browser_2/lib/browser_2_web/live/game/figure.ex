defmodule Browser2Web.Live.Game.Figure do
  use Browser2Web, :live_component

  def render(assigns) do
    ~H"""
    <p>Turns left: <%= assigns.turns_left %></p>
    """
  end
end
