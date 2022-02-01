defmodule TennisPhx.Matches do
  @moduledoc """
  The Matches context.
  """

  import Ecto.Query, warn: false
  alias TennisPhx.Repo

  alias TennisPhx.Matches.Match
  alias TennisPhx.Events.Tour
  alias TennisPhx.Participants.Player


  # =========== Assign Player v Player Match =============

  def assign_match(%Tour{} = tour, player1_id, player2_id, day, month, year, location, phase, unit) do
    tt = tour.id

    %Match{}
    |> Match.changeset(%{tour_id: tour.id, first_player_id: player1_id, second_player_id: player2_id, location_id: location, phase_id: phase, player_unit_id: unit})
    |> Repo.insert()

  end

  # =========== END Assign Player v Player Match =============

  # =========== Assign Match in Tour =============

  def get_match_for_tour(%Tour{} = tour) do
    tour_id = tour.id
    query = from(m in Match, where: m.tour_id == ^tour_id, order_by: [desc: m.phase_id])
    Repo.all(query)
  end

  # =========== END Assign Match in Tour =============

  def get_match_by_players(player1, player2) do
    query = from(m in Match, where: m.first_player_id == ^player1 and m.second_player_id == ^player2 or m.first_player_id == ^player2 and m.second_player_id == ^player1)
    Repo.all(query)
  end


  def get_last3_matches_by_player(%Player{} = player) do
    player_id = player.id
    query = from(m in Match, where: m.first_player_id == ^player_id or m.second_player_id == ^player_id)
    Repo.all(query) |> Enum.take(3)
  end

  def list_matches do
    Repo.all(Match)
  end


  def get_match!(id), do: Repo.get!(Match, id)

  def create_match(attrs \\ %{}) do
    %Match{}
    |> Match.changeset(attrs)
    |> Repo.insert()
  end


  def update_match(%Match{} = match, attrs) do
    match
    |> Match.changeset(attrs)
    |> Repo.update()
  end


  def delete_match(%Match{} = match) do
    Repo.delete(match)
  end


  def change_match(%Match{} = match, attrs \\ %{}) do
    Match.changeset(match, attrs)
  end
end
