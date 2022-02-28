defmodule TennisPhx.PlayerTour do
  @moduledoc """
  The PlayerTour context.
  """
  import Ecto.Query, warn: false
  alias TennisPhx.Repo
  alias TennisPhx.Events.Tour

  alias TennisPhx.Events.PlayerTour

  @doc """
  Returns the list of player_tour.
  """

  def list_players_in_tour(%Tour{} = tour) do
    tour_id = tour.id
    filter = from(pt in PlayerTour, where: pt.tour_id == ^tour_id, order_by: [desc: pt.points, asc: pt.player_id])
    Repo.all(filter)
  end



end
