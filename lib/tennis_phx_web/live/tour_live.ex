defmodule TennisPhxWeb.TourLive do
  use TennisPhxWeb, :live_view

  alias TennisPhx.Repo
  alias TennisPhxWeb.TourView
  alias TennisPhx.Events
  alias TennisPhx.Participants



  def render(assigns) do
   render TourView, "show.html", assigns
  end

  @impl true
  def mount(params, _, socket) do
    tour = Events.get_tour!(params["id"])
    players = Participants.list_players()
    players_for_tour = tour.players |> Repo.preload(:tours)
    tour_players = Events.tour_players(tour)
                   |>Enum.map(fn(x) -> x.player_id end)
    socket = assign(
        socket,
        tour: tour,
        players: players,
        tour_players: tour_players,
        players_for_tour: players_for_tour
      )
    {:ok, socket}
  end


  def handle_event("toggle_check", %{"player-id" => player_id}, socket) do
    tour = socket.assigns[:tour]
           |> Repo.preload(:players)
    players_for_tour = tour.players |> Repo.preload(:tours)
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

  def handle_event("assign_match",
                  %{"player1" => %{"player1_id" => player1_id},
                  "player1_games" => %{"player1_games" => player1_games},
                  "player2" => %{"player2_id" => player2_id},
                  "player2_games" => %{"player2_games" => player2_games}},
                  socket) do
    tour = socket.assigns[:tour]
           |> Repo.preload(:players)
    Events.assign_match_result(tour, player1_id, player1_games, player2_id, player2_games)
    {:noreply, socket}
  end

end
