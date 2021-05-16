defmodule BoarTailWeb.ItemsView do
  use BoarTailWeb, :view
  alias BoarTailWeb.ItemsView

  def render("index.json", %{items: items}) do
    %{data: render_many(items, ItemsView, "items.json")}
  end

  def render("show.json", %{items: items}) do
    %{data: render_one(items, ItemsView, "items.json")}
  end

  def render("items.json", %{items: items}) do
    %{
      id: items.id,
      name: items.name,
      description: items.description,
      cost: items.cost}
  end
end
