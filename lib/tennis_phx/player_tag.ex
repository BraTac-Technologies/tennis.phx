defmodule TennisPhx.PlayerTag do
  @moduledoc """
  The PlayerTour context.
  """
  import Ecto.Query, warn: false
  alias TennisPhx.Repo
  alias TennisPhx.Tags.Tag
  alias TennisPhx.Participants.Player
  alias TennisPhx.Participants.PlayerTag

  @doc """
  Returns the list of player_tour.
  """

  def assign_player_points(%Tag{} = tag, player_id, points_for_player) do
    tt = tag.id

    filter = from(pt in PlayerTag, where: pt.tag_id == ^tt and pt.player_id == ^player_id, select: pt.points)
    current_points = Repo.one(filter)


    updated_points = String.to_integer(points_for_player) + Decimal.to_integer(current_points)

    query = from(pt in PlayerTag, where: pt.tag_id == ^tt and pt.player_id == ^player_id, preload: [:tag, :player])
    assoc = Repo.one(query)

    assoc
    |> PlayerTag.changeset(%{points: updated_points})
    |> Repo.update()

  end

  def list_players_ranking_by_tag(%Tag{} = tag) do
    tag_id = tag.id
    filter = from(pt in PlayerTag, where: pt.tag_id == ^tag_id, order_by: [desc: pt.points])
    Repo.all(filter)
  end

end
