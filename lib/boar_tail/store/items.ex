defmodule BoarTail.Store.Items do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :cost, :decimal
    field :description, :string
    field :id, Ecto.UUID
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(items, attrs) do
    items
    |> cast(attrs, [:id, :name, :description, :cost])
    |> validate_required([:id, :name, :description, :cost])
  end
end
