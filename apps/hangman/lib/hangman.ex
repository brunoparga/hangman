defmodule Hangman do
  alias Hangman.{Runtime.Server, Type}
  @opaque server :: Server.t()

  @spec make_move(server, String.t()) :: {server, Type.tally()}
  def make_move(server, guess) do
    GenServer.call(server, {:make_move, guess})
  end

  @spec new_game() :: server
  def new_game do
    {:ok, pid} = GenServer.start_link(Server, nil)
    pid
  end

  @spec tally(server) :: Type.tally()
  def tally(server) do
    GenServer.call(server, {:tally})
  end
end
