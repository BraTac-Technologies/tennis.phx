defmodule TennisPhxWeb.HeadtoHeadLive do
  use TennisPhxWeb, :live_view

  alias TennisPhx.Repo
  alias TennisPhxWeb.PageView
  alias TennisPhx.Participants

  def render(assigns) do
   render PageView, "headtohead.html", assigns
  end


  @impl true
  def mount(params, _, socket) do
    id = 1
    player = Participants.get_player!(id)
    winrate = Participants.get_winrate(player)
    match_count = Participants.get_match_count(player)

    socket = assign(
        socket,
        player: player,
        winrate: winrate,
        match_count: match_count
      )
    {:ok, socket}
  end

end
