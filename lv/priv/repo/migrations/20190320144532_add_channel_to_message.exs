defmodule Lv.Repo.Migrations.AddChannelToMessage do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :channel, :string
    end
  end
end
