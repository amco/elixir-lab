defmodule Lv.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :name, :string
    field :text, :string
    field :channel, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :text, :channel])
    |> validate_required([:name, :text, :channel])
  end
end
