defmodule TennisPhx.Participants do
  @moduledoc """
  The Participants context.
  """

  import Ecto.Query, warn: false
  alias TennisPhx.Repo

  alias TennisPhx.Participants.Player
  alias TennisPhx.Matches.Match

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

  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player!(123)
      %Player{}

      iex> get_player!(456)
      ** (Ecto.NoResultsError)

  """
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


  def get_player!(id) do
    Repo.get!(Player, id)
    |> Repo.preload(:tours)
  end

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
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
