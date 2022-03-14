defmodule Fibs do
  def start do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
  end

  def read_fib(agent, number) do
    Agent.get(agent, &Map.get(&1, number))
  end

  def set_fib(agent, number, value) do
    Agent.get_and_update(agent, &{value, Map.put(&1, number, value)})
  end

  def fib(agent, number) do
    case read_fib(agent, number) do
      nil ->
        value = fib(agent, number - 1) + fib(agent, number - 2)
        set_fib(agent, number, value)

      value ->
        value
    end
  end
end
