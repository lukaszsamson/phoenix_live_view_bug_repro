defmodule DemoWeb.ConfigLive do
  use Phoenix.LiveView

  def mount(_, socket) do
    {:ok,
     assign(socket, %{
       sides: %{
         side_a: %{
           name: "Side A",
           levels: []
         },
         side_b: %{
           name: "Side B",
           levels: []
         }
       }
     })}
  end

  def render(assigns), do: Phoenix.View.render(DemoWeb.ConfigView, "edit.html", assigns)

  def handle_event("add_level_" <> side, _, socket) when side in ["side_a", "side_b"] do
    side = String.to_atom(side)
    sides = socket.assigns.sides

    {_, updated_sides} =
      get_and_update_in(sides[side][:levels], fn prev ->
        {prev,
         [
           %{
             changeset: %Demo.Level{} |> Demo.Level.changeset(%{})
           }
           | prev
         ]}
      end)

    updated_sides |> IO.inspect()

    {:noreply, assign(socket, :sides, updated_sides)}
  end
end
