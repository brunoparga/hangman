defmodule Browser2Web.Live.Game.Alphabet do
  use Browser2Web, :live_component

  def render(assigns) do
    ~H"""
    <p>a b c d e f g h i j k l m n o p q r s t u v w x y z</p>
    """
  end
end
