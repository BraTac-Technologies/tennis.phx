defmodule TennisPhxWeb.TourController do
  use TennisPhxWeb, :controller

  alias TennisPhx.Repo
  alias TennisPhx.Events
  alias TennisPhx.Events.Tour
  alias TennisPhx.Participants
  alias TennisPhx.Statuses.Status
  alias TennisPhx.Statuses
  alias TennisPhx.Locations

  def index(conn, _params) do
    statuses = Statuses.list_statuses()
    tours = Events.list_tours() |> Repo.preload(:status) |> Repo.preload(:location)
    players = Participants.list_players()
    render(conn, "index.html", tours: tours, players: players)
  end

  def new(conn, _params) do
    changeset = Events.change_tour(%Tour{})
    locations = Locations.list_locations()
    render(conn, "new.html", changeset: changeset, locations: locations)
  end

  def create(conn, %{"tour" => tour_params}) do
    case Events.create_tour(tour_params) do
      {:ok, tour} ->
        conn
        |> put_flash(:info, "Tour created successfully.")
        |> redirect(to: Routes.tour_path(conn, :index))
        # Vremenno

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tour = Events.get_tour!(id)
    render(conn, "show.html", tour: tour)
  end

  def edit(conn, %{"id" => id}) do
    tour = Events.get_tour!(id)
    changeset = Events.change_tour(tour)
    locations = Locations.list_locations()
    render(conn, "edit.html", tour: tour, changeset: changeset, locations: locations)
  end

  def update(conn, %{"id" => id, "tour" => tour_params}) do
    tour = Events.get_tour!(id)

    case Events.update_tour(tour, tour_params) do
      {:ok, tour} ->
        conn
        |> put_flash(:info, "Tour updated successfully.")
        |> redirect(to: Routes.tour_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tour: tour, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tour = Events.get_tour!(id)
    {:ok, _tour} = Events.delete_tour(tour)

    conn
    |> put_flash(:info, "Tour deleted successfully.")
    |> redirect(to: Routes.tour_path(conn, :index))
  end
end
