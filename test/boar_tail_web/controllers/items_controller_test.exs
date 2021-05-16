defmodule BoarTailWeb.ItemsControllerTest do
  use BoarTailWeb.ConnCase

  alias BoarTail.Store
  alias BoarTail.Store.Items

  @create_attrs %{
    cost: "120.5",
    description: "some description",
    name: "some name"
  }
  @update_attrs %{
    cost: "456.7",
    description: "some updated description",
    name: "some updated name"
  }
  @invalid_attrs %{cost: nil, description: nil, id: nil, name: nil}

  def fixture(:items) do
    {:ok, items} = Store.create_items(@create_attrs)
    items
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all items", %{conn: conn} do
      conn = get(conn, Routes.items_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create items" do
    test "renders items when data is valid", %{conn: conn} do
      conn = post(conn, Routes.items_path(conn, :create), items: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.items_path(conn, :show, id))

      assert %{
               "cost" => "120.5",
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.items_path(conn, :create), items: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update items" do
    setup [:create_items]

    test "renders items when data is valid", %{conn: conn, items: %Items{id: id} = items} do
      conn = put(conn, Routes.items_path(conn, :update, items), items: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.items_path(conn, :show, id))

      assert %{
               "cost" => "456.7",
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, items: items} do
      conn = put(conn, Routes.items_path(conn, :update, items), items: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete items" do
    setup [:create_items]

    test "deletes chosen items", %{conn: conn, items: items} do
      conn = delete(conn, Routes.items_path(conn, :delete, items))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.items_path(conn, :show, items))
      end
    end
  end

  defp create_items(_) do
    items = fixture(:items)
    %{items: items}
  end
end
