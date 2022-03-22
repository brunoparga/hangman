defmodule Hangman do
  alias Hangman.{Runtime.Server, Type}
  @type tally :: Type.tally()
  @opaque server :: Server.t()

  @spec make_move(server, String.t()) :: tally()
  def make_move(server, guess) do
    GenServer.call(server, {:make_move, guess})
  end

  @spec new_game() :: server
  def new_game() do
    {:ok, pid} = Hangman.Runtime.Application.start_game()
    pid
  end

  @spec tally(server) :: tally()
  def tally(server) do
    GenServer.call(server, {:tally})
  end
end
