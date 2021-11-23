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
    tour = Events.get_tour!(params["id"])
    players = Participants.list_players()
    locations = Locations.list_locations()
    phases = Phases.list_phases()
    player_units = PlayerUnits.list_player_units()
    match_for_tour = Matches.get_match_for_tour(tour) |> Repo.preload(:location) |> Repo.preload(:first_player) |> Repo.preload(:second_player) |> Repo.preload(:phase)
    matches = Matches.list_matches()
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
        player_units: player_units,
        match_for_tour: match_for_tour,
        changeset: changeset
      )
    {:ok, socket}
  end


  def handle_event("toggle_check", %{"player-id" => player_id}, socket) do
    tour = socket.assigns[:tour]
              |> Repo.preload(:players)
    Events.toggle_tour_players(tour, player_id)
    tour_players = Events.tour_players(tour)
                   |>Enum.map(fn(x) -> x.player_id end)
                   {:noreply, assign(socket, :tour_players, tour_players)}
  end



  def handle_event("add_points", %{"player_id" => %{"player_id" => player_id}, "player_points" => %{"points" => points_for_player}}, socket) do
    tour = socket.assigns[:tour]
           |> Repo.preload(:players)
    Events.assign_player_points(tour, player_id, points_for_player)
    {:noreply, socket}
  end

  def handle_event("assign_match", %{
                                    "player1" => %{"player1_id" => player1_id},
                                    "player2" => %{"player2_id" => player2_id},
                                    "date" => %{"date" => %{
                                                            "day" => day,
                                                            "month" => month,
                                                            "year" => year
                                                                          }
                                                                        },
                                    "location" => %{"location" => location},
                                    "phase" => %{"phase" => phase},
                                    "unit" => %{"unit" => unit},
                                    }, socket) do


    tour = socket.assigns[:tour]
           |> Repo.preload(:players)
    Matches.assign_match(tour, player1_id, player2_id, day, month, year, location, phase, unit)
    {:noreply, socket}
  end

  def handle_event("assign_match_info", %{"match" => attrs}, socket) do

    case Matches.create_match(attrs) do
      {:ok, match} ->
        changeset = Matches.change_match(%Match{})

        socket = assign(socket, changeset: changeset)

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset.errors, label: "SHOW ERROR")

        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
      end
  end

  def handle_event("add_match_result", %{"match" => attrs}, socket) do
    match = Matches.get_match!(attrs["match_id"])

    case Matches.update_match(match, attrs) do
      {:ok, match} ->

        changeset = Matches.change_match(%Match{})

        socket = assign(socket, changeset: changeset)

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end

end
