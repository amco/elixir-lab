defmodule LvWeb.TimerLive do
  use Phoenix.LiveView
  import Calendar.Strftime

  def render(assigns) do
    color = :rand.uniform(255)

    ~L"""
      <div class="timer" style="background-color: rgb(<%= color %>,10,10);"><%= strftime!(@time, "%r") %></div>
      <button phx-click="change"><%= @label %></button>
    """
  end

  def mount(_session, socket) do
    if connected?(socket) do
      :timer.send_interval(10, self(), :update)
    end

    {:ok, timer(socket)}
  end

  def handle_info(:update, socket) do
    {:noreply, timer(socket)}
  end

  def handle_event("change", _, socket) do
    {:noreply, timer(assign(socket, %{timezone: toggle_timezone(socket)}))}
  end

  defp timer(socket) do
    assign(socket, time(socket))
  end

  defp toggle_timezone(%Phoenix.LiveView.Socket{assigns: %{timezone: :utc}}), do: :local
  defp toggle_timezone(%Phoenix.LiveView.Socket{assigns: %{timezone: :local}}), do: :utc
  defp toggle_timezone(%Phoenix.LiveView.Socket{assigns: %{}}), do: :utc

  defp time(%Phoenix.LiveView.Socket{assigns: %{timezone: :utc}}), do: %{time: :calendar.universal_time(), label: "To Local"}
  defp time(%Phoenix.LiveView.Socket{assigns: %{timezone: :local}}), do: %{time: :calendar.local_time(), label: "To UTC"}
  defp time(%Phoenix.LiveView.Socket{assigns: %{}}), do: %{time: :calendar.local_time(), label: "To UTC"}
end
