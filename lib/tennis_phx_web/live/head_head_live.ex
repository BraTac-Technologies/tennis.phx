defmodule TennisPhxWeb.HeadheadLive do
  use TennisPhxWeb, :live_view

  alias TennisPhx.Repo
  alias TennisPhxWeb.PageView
  alias TennisPhx.Events
  alias TennisPhx.Participants

  def render(assigns) do
   render PageView, "headhead.html", assigns
  end

  def mount(params, _, socket) do
    tours = Events.list_tours() |> Repo.preload(:players)
    players = Participants.list_players_ranking() |> Repo.preload(:tours)
    socket = assign(
        socket,
        tours: tours,
        players: players
      )
    {:ok, socket}
  end
end
