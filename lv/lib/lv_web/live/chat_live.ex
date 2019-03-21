defmodule LvWeb.ChatLive do
  use Phoenix.LiveView
  alias Lv.Chat
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    LvWeb.ChatView.render("new.html", assigns)
  end

  def mount(%{username: username, channel: channel}, socket) do
    if connected?(socket), do: Chat.subscribe(channel)
    {:ok, assign_socket(socket, channel, username)}
  end

  def handle_event("save", %{"message" => params}, socket) do
    Chat.create_message(attributes_for(socket, params))

    {:noreply, assign_socket(socket, socket_channel(socket))}
  end

  def socket_channel(%Socket{assigns: %{channel: channel}})  do
    channel
  end

  def handle_info({Chat, _event, result}, socket) do
    {:noreply, assign_socket(socket, result.channel)}
  end

  defp assign_socket(socket, channel, username \\ nil) do
    default_payload = %{messages: Chat.all(channel), changeset: Chat.new_message()}

    if username do
      assign(socket, Map.merge(default_payload, %{username: username, channel: channel}))
    else
      assign(socket, default_payload)
    end
  end

  defp attributes_for(%Socket{assigns: %{username: username, channel: channel}}, params) do
    Map.merge(params, %{"name" => username, "channel" =>  channel})
  end
end
