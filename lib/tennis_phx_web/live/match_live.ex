defmodule TennisPhxWeb.MatchLive do
  use TennisPhxWeb, :live_view


  alias TennisPhxWeb.MatchView

  def render(assigns) do
   render MatchView, "form.html", assigns
  end
end
