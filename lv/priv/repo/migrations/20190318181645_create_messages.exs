defmodule Lv.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :name, :string
      add :text, :string

      timestamps()
    end

  end
end
