defmodule TennisPhxWeb.PlayerController do
  use TennisPhxWeb, :controller

  alias TennisPhx.Participants
  alias TennisPhx.Participants.Player

  def index(conn, _params) do
    players = Participants.list_players()
    render(conn, "index.html", players: players)
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
        |> redirect(to: Routes.player_path(conn, :show, player))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    player = Participants.get_player!(id)
    render(conn, "show.html", player: player)
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
        |> put_flash(:info, "Player updated successfully.")
        |> redirect(to: Routes.player_path(conn, :show, player))

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
