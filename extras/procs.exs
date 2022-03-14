defmodule Procs do
  def greet(count) do
    receive do
      {:crash, reason} ->
        exit(reason)

      {:reset} ->
        greet(0)

      {:quit} ->
        IO.puts("I'm outta here!")

      {:add, n} ->
        greet(count + n)

      msg ->
        IO.puts("#{count}: Hello #{msg}")
        greet(count)
    end
  end
end
