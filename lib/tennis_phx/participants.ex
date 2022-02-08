defmodule TennisPhx.Participants do
  @moduledoc """
  The Participants context.
  """

  import Ecto.Query, warn: false
  alias TennisPhx.Repo

  alias TennisPhx.Participants.Player
  alias TennisPhx.Matches.Match
  alias TennisPhx.Participants.PlayerTag
  alias TennisPhx.Events.PlayerTour
  alias TennisPhx.Tags.Tag
  alias TennisPhx.Events.Tour

  @doc """
  Returns the list of players.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

  """
  def list_players do
    Repo.all(Player)
  end
  def list_players_ranking do
    filter = from(p in Player, order_by: [desc: p.points])
    Repo.all(filter)
  end

  # Player Show

  def get_winrate(%Player{} = player) do
    pi = player.id
    query = from(m in Match, where: m.winner_id == ^pi)
    Repo.all(query)
  end

  def get_match_count(%Player{} = player) do
    pi = player.id
    query = from(m in Match, where: m.first_player_id == ^pi or m.second_player_id == ^pi)
    Repo.all(query)
  end

  def get_player_v_player_wins(player1_id, player2_id) do
    query = from(m in Match, where: (m.first_player_id == ^player1_id and m.second_player_id == ^player2_id or m.first_player_id == ^player2_id and m.second_player_id == ^player1_id) and m.winner_id == ^player1_id)
    Repo.all(query)
  end


  def get_player!(id) do
    Repo.get!(Player, id)
    |> Repo.preload(:tours)
  end

  def get_id_of_player_by_name(player1_name) do
    query = from(p in Player, where: p.name == ^player1_name, select: p.id)
    Repo.one(query)
  end


  def toggle_player_tag(tag_id, player_id) do

    query = from(pt in PlayerTag, where: pt.tag_id == ^tag_id and pt.player_id == ^player_id)
    assoc = Repo.one(query)
    # require IEx; IEx.pry
    if assoc == nil do
      %PlayerTag{}
      |> PlayerTag.changeset(%{player_id: player_id, tag_id: tag_id})
      |> Repo.insert()
    else
      Repo.delete(assoc)
    end
  end

  def tag_players(%Tag{} = tag) do
    tag_id = tag.id
    query_join_table = from(pt in PlayerTag, where: pt.tag_id == ^tag_id)
    Repo.all(query_join_table)
  end

  def get_length_of_tour_wins(player_id) do
    query = from(t in Tour, where: t.winner_id == ^player_id)
    Repo.all(query)
  end

  def get_points_by_player_tour(player_id, tour_id) do
    query = from(pt in PlayerTour, where: pt.player_id == ^player_id and pt.tour_id == ^tour_id, select: pt.points)
    Repo.one(query)
  end


  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player, %{field: new_value})
      {:ok, %Player{}}

      iex> update_player(player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  def assign_player_points(%Player{} = player, points_for_player) do
    pp = player.points
    pi = player.id
    updated_points = pp + String.to_integer(points_for_player)
    query = from(p in Player, where: p.id == ^pi)
    assoc = Repo.one(query)

    assoc
    |> Player.changeset(%{points: updated_points})
    |> Repo.update()
  end

  @doc """
  Deletes a player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{data: %Player{}}

  """
  def change_player(%Player{} = player, attrs \\ %{}) do
    Player.changeset(player, attrs)
  end
end
