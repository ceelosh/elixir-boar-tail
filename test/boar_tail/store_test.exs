defmodule BoarTail.StoreTest do
  use BoarTail.DataCase

  alias BoarTail.Store

  describe "items" do
    alias BoarTail.Store.Items

    @valid_attrs %{cost: "120.5", description: "some description", id: "7488a646-e31f-11e4-aace-600308960662", name: "some name"}
    @update_attrs %{cost: "456.7", description: "some updated description", id: "7488a646-e31f-11e4-aace-600308960668", name: "some updated name"}
    @invalid_attrs %{cost: nil, description: nil, id: nil, name: nil}

    def items_fixture(attrs \\ %{}) do
      {:ok, items} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Store.create_items()

      items
    end

    test "list_items/0 returns all items" do
      items = items_fixture()
      assert Store.list_items() == [items]
    end

    test "get_items!/1 returns the items with given id" do
      items = items_fixture()
      assert Store.get_items!(items.id) == items
    end

    test "create_items/1 with valid data creates a items" do
      assert {:ok, %Items{} = items} = Store.create_items(@valid_attrs)
      assert items.cost == Decimal.new("120.5")
      assert items.description == "some description"
      assert items.id == "7488a646-e31f-11e4-aace-600308960662"
      assert items.name == "some name"
    end

    test "create_items/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_items(@invalid_attrs)
    end

    test "update_items/2 with valid data updates the items" do
      items = items_fixture()
      assert {:ok, %Items{} = items} = Store.update_items(items, @update_attrs)
      assert items.cost == Decimal.new("456.7")
      assert items.description == "some updated description"
      assert items.id == "7488a646-e31f-11e4-aace-600308960668"
      assert items.name == "some updated name"
    end

    test "update_items/2 with invalid data returns error changeset" do
      items = items_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_items(items, @invalid_attrs)
      assert items == Store.get_items!(items.id)
    end

    test "delete_items/1 deletes the items" do
      items = items_fixture()
      assert {:ok, %Items{}} = Store.delete_items(items)
      assert_raise Ecto.NoResultsError, fn -> Store.get_items!(items.id) end
    end

    test "change_items/1 returns a items changeset" do
      items = items_fixture()
      assert %Ecto.Changeset{} = Store.change_items(items)
    end
  end
end
