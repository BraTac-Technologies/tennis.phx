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
    tour_players = Events.tour_players(tour)
                   |>Enum.map(fn(x) -> x.player_id end)
    socket = assign(
        socket,
        tour: tour,
        players: players,
        tour_players: tour_players
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

  def handle_event("change_name", %{"player" => attrs}, %{"player-id" => player}, socket ) do
    Participants.change_player(player, attrs)

  end

end
