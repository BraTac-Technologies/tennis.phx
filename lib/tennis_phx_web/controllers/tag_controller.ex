defmodule TennisPhxWeb.TagController do
  use TennisPhxWeb, :controller

  alias TennisPhx.Tags
  alias TennisPhx.Tags.Tag
  alias TennisPhx.Events
  alias TennisPhx.PlayerTag
  alias TennisPhx.Repo
  alias TennisPhx.Locations

  def index(conn, _params) do
    tags = Tags.list_tags()
    render(conn, "index.html", tags: tags)
  end

  def new(conn, _params) do
    changeset = Tags.change_tag(%Tag{})
    locations = Locations.list_locations()
    render(conn, "new.html", locations: locations, changeset: changeset)
  end

  def create(conn, %{"tag" => tag_params}) do
    case Tags.create_tag(tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag created successfully.")
        |> redirect(to: Routes.admin_dashboard_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id) |> Repo.preload(:location)
    tours_for_tag = Events.get_tours_by_tag(tag) |> Repo.preload([:tag, :location])
    rankings = PlayerTag.list_players_ranking_by_tag(tag)  |> Repo.preload(:player)
    render(conn, "show.html", tag: tag, tours: tours_for_tag, rankings: rankings)
  end

  def edit(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)
    changeset = Tags.change_tag(tag)
    locations = Locations.list_locations()
    render(conn, "edit.html", tag: tag, locations: locations, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Tags.get_tag!(id)

    case Tags.update_tag(tag, tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag updated successfully.")
        |> redirect(to: Routes.admin_dashboard_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tag: tag, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)
    {:ok, _tag} = Tags.delete_tag(tag)

    conn
    |> put_flash(:info, "Tag deleted successfully.")
    |> redirect(to: Routes.admin_dashboard_path(conn, :index))
  end
end
