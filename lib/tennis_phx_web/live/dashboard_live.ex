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
  alias TennisPhx.Tags

  def render(assigns) do
   render DashboardView, "index.html", assigns
  end

  def mount(_params, _, socket) do
    tours = Events.list_tours() |> Repo.preload(:players)
    players = Participants.list_players_ranking() |> Repo.preload(:tours)
    locations = Locations.list_locations()
    phases = Phases.list_phases()
    player_units = PlayerUnits.list_player_units()
    statuses = Statuses.list_statuses()
    matches = Matches.list_matches()
    tags = Tags.list_tags()
    socket = assign(
        socket,
        tours: tours,
        locations: locations,
        phases: phases,
        player_units: player_units,
        statuses: statuses,
        players: players,
        matches: matches,
        tags: tags
      )
    {:ok, socket}
  end
end
