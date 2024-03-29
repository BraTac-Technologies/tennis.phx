defmodule TennisPhxWeb.PlayerController do
  use TennisPhxWeb, :controller

  alias TennisPhx.Repo
  alias TennisPhx.Participants
  alias TennisPhx.Participants.Player
  alias TennisPhx.Events
  alias TennisPhx.Matches
  alias TennisPhx.Tags

  def index(conn, _params) do
    players = Participants.list_players_ranking()
    tours = Events.list_tours()
    tags = Tags.list_tags()
    render(conn, "index.html", players: players, tours: tours, tags: tags)
  end

  def new(conn, _params) do
    changeset = Participants.change_player(%Player{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"player" => player_params}) do
    case Participants.create_player(player_params) do
      {:ok, player} ->
        conn
        |> put_flash(:info, "Player created successfully.")
        |> redirect(to: Routes.admin_dashboard_path(conn, :index))


      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    player = Participants.get_player!(id)
    winrate = Participants.get_winrate(player)
    match_count = Participants.get_match_count(player)
    points_and_tours_by_player = Events.points_and_tours_by_player(player) |> Repo.preload(:tour)
    matches = Matches.get_last6_matches_by_player(player)  |> Repo.preload(:location) |> Repo.preload(:first_player) |> Repo.preload(:second_player) |> Repo.preload(:phase) |> Repo.preload(:status) |> Repo.preload(:tour)
    won_tours = Participants.get_length_of_tour_wins(player.id) |> Repo.preload(:tag)
    # tours = Participants.get_tours_by_player(player) |> Repo.preload(:tour) |> Repo.preload(tour: [:tag])
    last5_tours = Events.get_last_tours_by_player(player, 5) |> Repo.preload(:tour)
    all_tours = Events.get_last_tours_by_player_desc(player) |> Repo.preload(tour: [:tag])
    render(conn, "show.html", player: player, winrate: winrate, match_count: match_count, points_and_tours_by_player: points_and_tours_by_player, matches: matches, won_tours: won_tours, last5_tours: last5_tours, all_tours: all_tours)
  end

  def edit(conn, %{"id" => id}) do
    player = Participants.get_player!(id)
    changeset = Participants.change_player(player)
    render(conn, "edit.html", player: player, changeset: changeset)
  end

  def update(conn, %{"id" => id, "player" => player_params}) do
    player = Participants.get_player!(id)

    case Participants.update_player(player, player_params) do
      {:ok, player} ->
        conn
        |> put_flash(:success, "Player created successfully.")
        |> put_flash(:info, "You can now enroll him in a tour")
        |> redirect(to: Routes.admin_dashboard_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", player: player, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    player = Participants.get_player!(id)
    {:ok, _player} = Participants.delete_player(player)

    conn
    |> put_flash(:info, "Player deleted successfully.")
    |> redirect(to: Routes.player_path(conn, :index))
  end
end
