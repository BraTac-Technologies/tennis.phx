defmodule TennisPhxWeb.TourLive do
  use TennisPhxWeb, :live_view

  alias TennisPhx.Repo
  alias TennisPhxWeb.TourView
  alias TennisPhx.Events

  alias TennisPhx.Participants
  alias TennisPhx.Locations
  alias TennisPhx.Phases
  alias TennisPhx.PlayerUnits
  alias TennisPhx.Statuses
  alias TennisPhx.Matches
  alias TennisPhx.Matches.Match



  def render(assigns) do
   render TourView, "show.html", assigns
  end

  @impl true
  def mount(params, _, socket) do
    tour = Events.get_tour!(params["id"]) |> Repo.preload(:location) |> Repo.preload(:winner)
    players = Participants.list_players()
    locations = Locations.list_locations()
    phases = Phases.list_phases()
    player_units = PlayerUnits.list_player_units()
    statuses = Statuses.list_statuses()
    match_for_tour = Matches.get_match_for_tour(tour) |> Repo.preload(:location) |> Repo.preload(:first_player) |> Repo.preload(:second_player) |> Repo.preload(:phase) |> Repo.preload(:status)
    matches = Matches.list_matches()
    tours = Events.list_tours()
    changeset = Matches.change_match(%Match{})
    players_for_tour = tour.players |> Repo.preload(:tours)
    tour_players = Events.tour_players(tour)
                   |>Enum.map(fn(x) -> x.player_id end)
    socket = assign(
        socket,
        tour: tour,
        players: players,
        tour_players: tour_players,
        players_for_tour: players_for_tour,
        locations: locations,
        phases: phases,
        tours: tours,
        player_units: player_units,
        statuses: statuses,
        match_for_tour: match_for_tour,
        changeset: changeset
      )
    {:ok, socket}
  end



end
