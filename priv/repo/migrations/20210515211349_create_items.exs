defmodule BoarTail.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :id, :uuid
      add :name, :string
      add :description, :string
      add :cost, :decimal

      timestamps()
    end

  end
end
