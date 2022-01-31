defmodule TennisPhxWeb.HeadtoHeadLive do
  use TennisPhxWeb, :live_view

  alias TennisPhx.Repo
  alias TennisPhxWeb.PageView
  alias TennisPhx.Participants
  alias TennisPhx.Matches
  alias TennisPhx.Matches.Match

  def render(assigns) do
   render PageView, "headtohead.html", assigns
  end


  @impl true
  def mount(params, _, socket) do
    changeset = Matches.change_match(%Match{})
    players = Participants.list_players()
    socket = assign(
        socket,
        matches: [],
        first_player: nil,
        second_player: nil,
        changeset: changeset
      )
    {:ok, socket}
  end

  def handle_event("search_for_matches", %{
                  "player1" => %{"player1" => player1},
                  "player2" => %{"player2" => player2}},
                  socket) do

    first_player = Participants.get_player!(player1)
    second_player = Participants.get_player!(player2)
    matches = Matches.get_match_by_players(player1, player2) |> Repo.preload(:first_player) |> Repo.preload(:second_player) |> Repo.preload(:phase) |> Repo.preload(:tour)

    socket = assign(
    socket,
    matches: matches,
    first_player: first_player,
    second_player: second_player
    )

    {:noreply, socket}

  end

end
