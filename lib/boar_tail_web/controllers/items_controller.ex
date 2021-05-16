defmodule BoarTailWeb.ItemsController do
  use BoarTailWeb, :controller

  alias BoarTail.Store
  alias BoarTail.Store.Items

  action_fallback BoarTailWeb.FallbackController

  def index(conn, _params) do
    items = Store.list_items()
    render(conn, "index.json", items: items)
  end

  def create(conn, %{"items" => items_params}) do
    with {:ok, %Items{} = items} <- Store.create_items(items_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.items_path(conn, :show, items))
      |> render("show.json", items: items)
    end
  end

  def show(conn, %{"id" => id}) do
    items = Store.get_items!(id)
    render(conn, "show.json", items: items)
  end

  def update(conn, %{"id" => id, "items" => items_params}) do
    items = Store.get_items!(id)

    with {:ok, %Items{} = items} <- Store.update_items(items, items_params) do
      render(conn, "show.json", items: items)
    end
  end

  def delete(conn, %{"id" => id}) do
    items = Store.get_items!(id)

    with {:ok, %Items{}} <- Store.delete_items(items) do
      send_resp(conn, :no_content, "")
    end
  end
end
