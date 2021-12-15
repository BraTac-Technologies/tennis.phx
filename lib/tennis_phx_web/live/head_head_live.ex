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

  def handle_event("suggest-player", %{"player1" => prefix}, socket) do
    socket = assign(socket, matches: Participants.suggest(prefix))
    {:noreply, socket}

  end
end
