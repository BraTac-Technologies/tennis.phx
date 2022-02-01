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
        players: players,
        changeset: changeset
      )
    {:ok, socket}
  end

  def handle_event("search_for_matches", %{
                  "player1" => %{"player1" => player1_name},
                  "player2" => %{"player2" => player2_name}},
                  socket) do

    player1_id = Participants.get_id_of_player_by_name(player1_name)
    player2_id = Participants.get_id_of_player_by_name(player2_name)

    first_player = Participants.get_player!(player1_id)
    second_player = Participants.get_player!(player2_id)

    matches = Matches.get_match_by_players(player1_id, player2_id) |> Repo.preload(:first_player) |> Repo.preload(:second_player) |> Repo.preload(:phase) |> Repo.preload(:tour)

    socket = assign(
    socket,
    matches: matches,
    first_player: first_player,
    second_player: second_player
    )


    {:noreply, socket}

  end

end
