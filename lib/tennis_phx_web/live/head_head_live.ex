defmodule TennisPhxWeb.HeadheadLive do
  use TennisPhxWeb, :live_view

  alias TennisPhx.Repo
  alias TennisPhxWeb.PageView
  alias TennisPhx.Events
  alias TennisPhx.Participants
  alias TennisPhx.Matches
  alias TennisPhx.Matches.Match

  def render(assigns) do
   render PageView, "headhead.html", assigns
  end

  def mount(params, _, socket) do
    tours = Events.list_tours()
    players = Participants.list_players()
    changeset = Matches.change_match(%Match{})
    socket = assign(
        socket,
        tours: tours,
        players: players,
        changeset: changeset
      )
    {:ok, socket}
  end

  def handle_event("get_players", %{"match" => attrs}, socket) do

  #  first_player = Participants.get_player_by_name!(attrs["first_player_name"])
 #   second_player = Participants.get_player_by_name!(attrs["second_player_name"])

    IO.inspect(attrs["first_player_name"], label: "MESSAFE===>")
    #get_match = TennisPhx.Matches.get_match_by_players(first_player, second_player)

    #socket = assign(socket, get_match: get_match)
    {:noreply, socket}

  end
end
