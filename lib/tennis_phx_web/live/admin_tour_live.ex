defmodule TennisPhxWeb.AdminTourLive do
  use TennisPhxWeb, :live_view

  alias TennisPhx.Repo
  alias TennisPhxWeb.DashboardView

  alias TennisPhx.Events
  alias TennisPhx.Events.Tour
  alias TennisPhx.Participants
  alias TennisPhx.Locations
  alias TennisPhx.Phases
  alias TennisPhx.PlayerUnits
  alias TennisPhx.Statuses
  alias TennisPhx.Matches
  alias TennisPhx.Matches.Match
  alias TennisPhx.Tags
  alias TennisPhx.PlayerTag

  def render(assigns) do
   render DashboardView, "tour.html", assigns
  end

  @impl true
  def mount(params, _, socket) do
    tour = Events.get_tour!(params["id"])
    tag_id = tour.id
    tag = Tags.get_tag!(tag_id)
    players = Participants.list_players()
    locations = Locations.list_locations()
    phases = Phases.list_phases()
    player_units = PlayerUnits.list_player_units()
    statuses = Statuses.list_statuses()
    match_for_tour = Matches.get_match_for_tour(tour) |> Repo.preload(:location) |> Repo.preload(:first_player) |> Repo.preload(:second_player) |> Repo.preload(:phase) |> Repo.preload(:status)
    matches = Matches.list_matches()
    changeset = Matches.change_match(%Match{})
    changeset_for_tour = Events.change_tour(%Tour{})
    players_for_tour = tour.players |> Repo.preload(:tours)
    tags = Tags.list_tags()
    tour_players = Events.tour_players(tour)
                   |>Enum.map(fn(x) -> x.player_id end)
    tag_players = Participants.tag_players(tag)
                  |> Enum.map(fn(x) -> x.player_id end)

    socket = assign(
        socket,
        tour: tour,
        players: players,
        tour_players: tour_players,
        players_for_tour: players_for_tour,
        locations: locations,
        phases: phases,
        player_units: player_units,
        statuses: statuses,
        tags: tags,
        match_for_tour: match_for_tour,
        changeset: changeset,
        changeset_for_tour: changeset_for_tour,
        tag_players: tag_players,
        tag: tag
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

  def handle_event("toggle_check_player_tag", %{"player-id" => player_id}, socket) do
    tour = socket.assigns[:tour]
              |> Repo.preload(:players)
    tag_id = tour.id
    tag = Tags.get_tag!(tag_id)
    Participants.toggle_player_tag(tag_id, player_id)
    tag_players = Participants.tag_players(tag)
                  |> Enum.map(fn(x) -> x.player_id end)
                  {:noreply, assign(socket, :tag_players, tag_players)}

  end


  def handle_event("add_points", %{"player_id" => %{"player_id" => player_id}, "player_points" => %{"points" => points_for_player}}, socket) do
    tour = socket.assigns[:tour]
           |> Repo.preload(:players)

    # Assign points in player_tour
    Events.assign_player_points(tour, player_id, points_for_player)
    # Assign points in player
    player = Participants.get_player!(player_id)
    Participants.assign_player_points(player, points_for_player)
    # Assign points in player_tag
    tag = socket.assigns[:tag]
    PlayerTag.assign_player_points(tag, player_id, points_for_player)

    {:noreply, socket}
  end


  def handle_event("assign_match_info", %{"match" => attrs}, socket) do

    case Matches.create_match(attrs) do
      {:ok, match} ->
        socket

        changeset = Matches.change_match(%Match{})
        socket = put_flash(socket, :success, "Match added successfully!")
        socket = put_flash(socket, :info, "You can now assign score for it")
        socket = assign(socket, changeset: changeset)

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->

        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
      end
  end

  def handle_event("add_match_result", %{"match" => attrs}, socket) do
    match = Matches.get_match!(attrs["match_id"])

    case Matches.update_match(match, attrs) do
      {:ok, match} ->

        changeset = Matches.change_match(%Match{})

        socket = put_flash(socket, :success, "Score assigned successfully!")
        socket = put_flash(socket, :info, "Status of this match is auto setted to 'Finished' ")
        socket = assign(socket, changeset: changeset)

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end

  def handle_event("assign_tour_info", %{"tour" => attrs}, socket) do
    tour = socket.assigns[:tour]

    case Events.update_tour(tour, attrs) do
      {:ok, tour} ->

        changeset_for_tour = Events.change_tour(%Tour{})

        socket = put_flash(socket, :success, "Match details successfully updated!")
        socket = put_flash(socket, :info, "You can now view the status and the winner at 'Tours' ")
        socket = assign(socket, changeset_for_tour: changeset_for_tour)

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset_for_tour} ->
        socket = assign(socket, changeset_for_tour: changeset_for_tour)
        {:noreply, socket}
    end
  end

end
