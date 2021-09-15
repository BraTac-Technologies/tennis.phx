defmodule TennisPhxWeb.Player_unitController do
  use TennisPhxWeb, :controller

  alias TennisPhx.PlayerUnits
  alias TennisPhx.PlayerUnits.Player_unit

  def index(conn, _params) do
    player_units = PlayerUnits.list_player_units()
    render(conn, "index.html", player_units: player_units)
  end

  def new(conn, _params) do
    changeset = PlayerUnits.change_player_unit(%Player_unit{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"player_unit" => player_unit_params}) do
    case PlayerUnits.create_player_unit(player_unit_params) do
      {:ok, player_unit} ->
        conn
        |> put_flash(:info, "Player unit created successfully.")
        |> redirect(to: Routes.player_unit_path(conn, :show, player_unit))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    player_unit = PlayerUnits.get_player_unit!(id)
    render(conn, "show.html", player_unit: player_unit)
  end

  def edit(conn, %{"id" => id}) do
    player_unit = PlayerUnits.get_player_unit!(id)
    changeset = PlayerUnits.change_player_unit(player_unit)
    render(conn, "edit.html", player_unit: player_unit, changeset: changeset)
  end

  def update(conn, %{"id" => id, "player_unit" => player_unit_params}) do
    player_unit = PlayerUnits.get_player_unit!(id)

    case PlayerUnits.update_player_unit(player_unit, player_unit_params) do
      {:ok, player_unit} ->
        conn
        |> put_flash(:info, "Player unit updated successfully.")
        |> redirect(to: Routes.player_unit_path(conn, :show, player_unit))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", player_unit: player_unit, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    player_unit = PlayerUnits.get_player_unit!(id)
    {:ok, _player_unit} = PlayerUnits.delete_player_unit(player_unit)

    conn
    |> put_flash(:info, "Player unit deleted successfully.")
    |> redirect(to: Routes.player_unit_path(conn, :index))
  end
end
