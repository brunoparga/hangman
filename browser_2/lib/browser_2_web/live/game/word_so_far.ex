defmodule Browser2Web.Live.Game.WordSoFar do
  use Browser2Web, :live_component

  def render(assigns) do
    ~H"""
    <p>Word so far: <%= assigns.word_so_far %></p>
    """
  end
end
