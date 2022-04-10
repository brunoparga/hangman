defmodule Browser2Web.Live.Game.Alphabet do
  use Browser2Web, :live_component

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
