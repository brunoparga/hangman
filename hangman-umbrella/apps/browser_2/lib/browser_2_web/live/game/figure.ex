defmodule Browser2Web.Live.Game.Figure do
  use Browser2Web, :live_component

  defp should_hide(turns_left, level) do
    if turns_left > level, do: "hide-component", else: ""
  end
end
