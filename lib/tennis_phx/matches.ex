defmodule TennisPhx.Matches do
  @moduledoc """
  The Matches context.
  """

  import Ecto.Query, warn: false
  alias TennisPhx.Repo

  alias TennisPhx.Matches.Match
  alias TennisPhx.Events.Tour
  alias TennisPhx.Participants.Player




  # =========== END Assign Player v Player Match =============

  # =========== Assign Match in Tour =============

  def get_match_for_tour(%Tour{} = tour) do
    tour_id = tour.id
    query = from(m in Match, where: m.tour_id == ^tour_id, order_by: [desc: m.phase_id])
    Repo.all(query)
  end

  # =========== END Assign Match in Tour =============

  def get_match_by_players(player1, player2) do
    query = from(m in Match, where: m.first_player_id == ^player1 and m.second_player_id == ^player2 or m.first_player_id == ^player2 and m.second_player_id == ^player1, order_by: [desc: m.starting_datetime])
    Repo.all(query)
  end


  def get_last_matches_by_player(%Player{} = player, limit) do
    player_id = player.id
    query = from(m in Match, where: m.first_player_id == ^player_id or m.second_player_id == ^player_id, order_by: [desc: m.starting_datetime, desc: m.phase_id], limit: ^limit)
    Repo.all(query)
  end


  def get_matches_by_player_and_tour(player_id, tour_id) do
    query = from(m in Match, where: m.tour_id == ^tour_id and (m.first_player_id == ^player_id or m.second_player_id == ^player_id))
    Repo.all(query)
  end

  def get_winner_matches_by_player_and_tour(player_id, tour_id) do
    query = from(m in Match, where: m.tour_id == ^tour_id and m.winner_id == ^player_id)
    Repo.all(query)
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
