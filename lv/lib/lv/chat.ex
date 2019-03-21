defmodule Lv.Chat do
  import Ecto.Query
  alias Lv.{Repo, Message}
  alias Phoenix.PubSub

  @topic inspect(__MODULE__)

  def all(channel, limit \\ 100) do
    Repo.all from m in Message,
             limit: ^limit,
             where: m.channel == ^channel,
             order_by: [desc: m.id]
  end

  def new_message, do: Message.changeset(%Message{}, %{})

  def create_message(params) do
    %Message{}
    |> Message.changeset(params)
    |> Repo.insert()
    |> notify_subscribers([:message, :created])
  end

  def subscribe(channel) do
    PubSub.subscribe(Lv.PubSub, @topic <>  ":#{channel}")
  end

  def notify_subscribers({:ok, result}, event) do
    PubSub.broadcast(Lv.PubSub, @topic <> ":#{result.channel}", {__MODULE__, event, result})

    {:ok, result}
  end

  def notify_subscribers({:error, reason}, _event), do: {:error, reason}
end
