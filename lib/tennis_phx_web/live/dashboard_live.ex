defmodule TennisPhxWeb.DashboardLive do
  use TennisPhxWeb, :live_view

  alias TennisPhx.Repo
  alias TennisPhxWeb.DashboardView

  alias TennisPhx.Events
  alias TennisPhx.Participants
  alias TennisPhx.Locations
  alias TennisPhx.Phases
  alias TennisPhx.PlayerUnits
  alias TennisPhx.Statuses
  alias TennisPhx.Matches
  alias TennisPhx.Matches.Match

  def render(assigns) do
   render DashboardView, "index.html", assigns
  end

  def mount(params, _, socket) do
    tours = Events.list_tours()
    players = Participants.list_players()
    socket = assign(
        socket,
        tours: tours,
        players: players
      )
    {:ok, socket}
  end
end
