defmodule Hangman.Runtime.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Hangman.Runtime.Server, []}
    ]

    options = [
      name: Hangman.Runtime.Supervisor,
      strategy: :one_for_one
    ]

    Supervisor.start_link(children, options)
  end
end
