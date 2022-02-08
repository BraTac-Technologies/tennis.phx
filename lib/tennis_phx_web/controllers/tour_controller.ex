defmodule TennisPhxWeb.TourController do
  use TennisPhxWeb, :controller

  alias TennisPhx.Repo
  alias TennisPhx.Events
  alias TennisPhx.Events.Tour
  alias TennisPhx.Participants
  alias TennisPhx.Statuses.Status
  alias TennisPhx.Statuses
  alias TennisPhx.Locations
  alias TennisPhx.Tags

  def index(conn, _params) do
    statuses = Statuses.list_statuses()
    tours = Events.list_tours() |> Repo.preload(:status) |> Repo.preload(:location) |> Repo.preload(:winner)
    players = Participants.list_players()
    locations = Locations.list_locations()
    render(conn, "index.html", tours: tours, players: players)
  end

  def new(conn, _params) do
    changeset = Events.change_tour(%Tour{})
    locations = Locations.list_locations()
    tags = Tags.list_tags()
    render(conn, "new.html", changeset: changeset, locations: locations, tags: tags)
  end

  def create(conn, %{"tour" => tour_params}) do
    locations = Locations.list_locations()
    case Events.create_tour(tour_params) do
      {:ok, tour} ->
        conn
        |> put_flash(:success, "Tour created successfully.")
        |> put_flash(:info, "You can now add players in the tour")
        |> redirect(to: Routes.admin_dashboard_path(conn, :index))
        # Vremenno

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    locations = Locations.list_locations()
    tour = Events.get_tour!(id)
    render(conn, "show.html", tour: tour)
  end

  def edit(conn, %{"id" => id}) do
    tour = Events.get_tour!(id)
    changeset = Events.change_tour(tour)
    locations = Locations.list_locations()
    tags = Tags.list_tags()
    render(conn, "edit.html", tour: tour, changeset: changeset, tags: tags)
  end

  def update(conn, %{"id" => id, "tour" => tour_params}) do
    tour = Events.get_tour!(id)
    locations = Locations.list_locations()

    case Events.update_tour(tour, tour_params) do
      {:ok, tour} ->
        conn
        |> put_flash(:info, "Tour updated successfully.")
        |> redirect(to: Routes.admin_dashboard_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tour: tour, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tour = Events.get_tour!(id)
    {:ok, _tour} = Events.delete_tour(tour)

    conn
    |> put_flash(:info, "Tour deleted successfully.")
    |> redirect(to: Routes.admin_dashboard_path(conn, :index))
  end
end
