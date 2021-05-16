defmodule BoarTail.Store.Items do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "items" do
    field :cost, :decimal
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(items, attrs) do
    items
    |> cast(attrs, [:name, :description, :cost])
    |> validate_required([:name, :description, :cost])
  end
end
