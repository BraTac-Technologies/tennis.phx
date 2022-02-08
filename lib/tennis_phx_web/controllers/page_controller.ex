defmodule TennisPhxWeb.PageController do
  use TennisPhxWeb, :controller

  alias TennisPhx.Repo
  alias TennisPhx.Participants
  alias TennisPhx.Events
  alias TennisPhx.Tags

  def index(conn, _params) do
    conn
    # |> put_flash(:success, "Player added successfully!")
    # |> put_flash(:info, "You can check all players at player#index")
    # |> put_flash(:error, "Let's pretend we have an error.")
    |> render("index.html")
  end

  def ranking(conn, _params) do
    players = Participants.list_players_ranking()
    tours = Events.list_tours()
    tags = Tags.list_tags()
    render(conn, "ranking.html", players: players, tours: tours, tags: tags)
  end
end
