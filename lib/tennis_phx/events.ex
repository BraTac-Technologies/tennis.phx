defmodule TennisPhx.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias TennisPhx.Repo

  alias TennisPhx.Events.Tour
  alias TennisPhx.Participants.Player
  alias TennisPhx.Events.PlayerTour
  alias TennisPhx.Events.PlayerVsPlayer

  @doc """
  Returns the list of tours.

  ## Examples

      iex> list_tours()
      [%Tour{}, ...]

  """
  def list_tours do
    Repo.all(Tour)
  end

  # ========== Player_Tour Many_to_Many ==========


  def toggle_tour_players(%Tour{} = tour, player_id) do
    tt = tour.id
    query = from(pt in PlayerTour, where: pt.tour_id == ^tt and pt.player_id == ^player_id)
    assoc = Repo.one(query)
    # require IEx; IEx.pry
    if assoc == nil do
      %PlayerTour{}
      |> PlayerTour.changeset(%{player_id: player_id, tour_id: tour.id})
      |> Repo.insert()
    else
      Repo.delete(assoc)
    end
  end

  def tour_players(%Tour{} = tour) do
    tour_id = tour.id
    query_join_table = from(pt in PlayerTour, where: pt.tour_id == ^tour_id)
    Repo.all(query_join_table)
  end

  # ========== END Player_Tour Many_to_Many END ==========

  # =============== Assign Player Points =================


  def assign_player_points(%Tour{} = tour, player_id, points_for_player) do
    tt = tour.id
    query = from(pt in PlayerTour, where: pt.tour_id == ^tt and pt.player_id == ^player_id, preload: [:tour, :player])
    assoc = Repo.one(query)

    assoc
    |> PlayerTour.changeset(%{points: points_for_player})
    |> Repo.update()
  end

  # ============= END Assign Player Points ===============

  # =========== Assign Player v Player Match =============

  def assign_match_result(%Tour{} = tour, player1_id, player1_games, player2_id, player2_games) do
    tt = tour.id
    query = from(pp in PlayerVsPlayer, where: pp.tour_id == ^tt and pp.player1_id == ^player1_id and pp.player2_id == ^player2_id and pp.player1_games == ^player1_games and pp.player2_games == ^player2_games)
    assoc = Repo.one(query)

    if assoc == nil do
      %PlayerVsPlayer{}
      |> PlayerVsPlayer.changeset(%{tour_id: tour.id, player1_id: player1_id, player2_id: player2_id, player1_games: player1_games, player2_games: player2_games})
      |> Repo.insert()
    else
      Repo.delete(assoc)
    end
  end


  def get_tour!(id) do
    Repo.get!(Tour, id)
    |> Repo.preload(:players)
  end

  @doc """
  Creates a tour.

  ## Examples

      iex> create_tour(%{field: value})
      {:ok, %Tour{}}

      iex> create_tour(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tour(attrs \\ %{}) do
    %Tour{}
    |> Tour.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tour.

  ## Examples

      iex> update_tour(tour, %{field: new_value})
      {:ok, %Tour{}}

      iex> update_tour(tour, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tour(%Tour{} = tour, attrs) do
    tour
    |> Tour.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tour.

  ## Examples

      iex> delete_tour(tour)
      {:ok, %Tour{}}

      iex> delete_tour(tour)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tour(%Tour{} = tour) do
    Repo.delete(tour)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tour changes.

  ## Examples

      iex> change_tour(tour)
      %Ecto.Changeset{data: %Tour{}}

  """
  def change_tour(%Tour{} = tour, attrs \\ %{}) do
    Tour.changeset(tour, attrs)
  end
end
