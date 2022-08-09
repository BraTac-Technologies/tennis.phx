defmodule TennisPhxWeb.PlayerShowLive do
  use TennisPhxWeb, :live_view

  alias TennisPhx.Repo
  alias TennisPhxWeb.PlayerView
  alias TennisPhx.Participants
  alias TennisPhx.Matches
  alias TennisPhx.Events
  alias TennisPhx.Tags

  def render(assigns) do
   render PlayerView, "show.html", assigns
  end


  @impl true
  def mount(params, _, socket) do
    player = Participants.get_player!(params["id"])
    winrate = Participants.get_winrate(player)
    match_count = Participants.get_match_count(player)
    points_and_tours_by_player = Events.points_and_tours_by_player(player) |> Repo.preload(:tour)
    won_tours = Participants.get_length_of_tour_wins(player.id) |> Repo.preload(:tag)
    # tours = Participants.get_tours_by_player(player) |> Repo.preload(:tour) |> Repo.preload(tour: [:tag])
    last5_tours = Events.get_last_tours_by_player(player, 5) |> Repo.preload(:tour)
    all_tours = Events.get_last_tours_by_player(player, 10) |> Repo.preload(tour: [:tag])
    passed_quarter_tours = Events.get_passed_quarter_tours(player)
    passed_semis_tours = Events.get_passed_semis_tours(player)
    lost_quarter_tours = Events.get_lost_quarter_tours(player)
    lost_semis_tours = Events.get_lost_semis_tours(player)
    lost_final_tours = Events.get_lost_final_tours(player)
    tags = Tags.list_tags()
    socket = assign(
        socket,
        player: player,
        winrate: winrate,
        match_count: match_count,
        points_and_tours_by_player: points_and_tours_by_player,
        won_tours: won_tours,
        last5_tours: last5_tours,
        all_tours: all_tours,
        tags: tags,
        passed_quarter_tours: passed_quarter_tours,
        passed_semis_tours: passed_semis_tours,
        lost_quarter_tours: lost_quarter_tours,
        lost_semis_tours: lost_semis_tours,
        lost_final_tours: lost_final_tours
      )
      socket =
        socket
        |> assign(limit: 6)
        |> load_matches()

    {:ok, socket}
  end

  defp load_matches(socket) do
    assign(
      socket,
      matches: Matches.get_last_matches_by_player(socket.assigns.player, socket.assigns.limit)  |> Repo.preload(:location) |> Repo.preload(:first_player) |> Repo.preload(:second_player) |> Repo.preload(:phase) |> Repo.preload(:status) |> Repo.preload(:tour) |> Repo.preload([tour: :tag])
    )
  end

  def handle_event("load-more-matches", _, socket) do
    socket =
      socket
      |> update(:limit, &(&1 + 3))
      |> load_matches

    {:noreply, socket}
  end


end
