defmodule MemoryWeb.Live.MemoryDisplay do
  use MemoryWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, schedule_tick_and_update_assigns(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, schedule_tick_and_update_assigns(socket)}
  end

  def render(assigns) do
    ~L"""
    <h2>Memory state as of <%= assigns.time %></h2>
    <table>
      <%= for {name, value} <- assigns.memory do %>
        <tr>
          <th><%= name %></th>
          <td><%= value %></td>
        </tr>
      <% end %>
    </table>
    """
  end

  defp schedule_tick_and_update_assigns(socket) do
    Process.send_after(self(), :tick, 1000)
    time =
      DateTime.utc_now()
      |> DateTime.truncate(:second)
      |> DateTime.to_string()

    assign(socket, :memory, :erlang.memory())
    |> assign(:time, time)
  end
end
