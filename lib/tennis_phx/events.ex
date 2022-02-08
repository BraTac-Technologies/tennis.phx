defmodule TennisPhx.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias TennisPhx.Repo

  alias TennisPhx.Events.Tour
  alias TennisPhx.Participants.Player
  alias TennisPhx.Events.PlayerTour

  @doc """
  Returns the list of tours.

  ## Examples

      iex> list_tours()
      [%Tour{}, ...]

  """
  def list_tours do
    filter = from(t in Tour, order_by: [desc: t.date])
    Repo.all(filter)
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

  def get_player_points_by_tour(tour_id, player_id) do
    query = from(pt in PlayerTour, where: pt.tour_id == ^tour_id and pt.player_id == ^player_id, select: pt.points)
    Repo.one(query)
  end

  def points_and_tours_by_player(%Player{} = player) do
    player_id = player.id
    query = from(pt in PlayerTour, where: pt.player_id == ^player_id, order_by: [desc: pt.points])
    Repo.all(query)
  end

  # ========== END Player_Tour Many_to_Many END ==========


  def assign_player_points(%Tour{} = tour, player_id, points_for_player) do
    tt = tour.id

    filter = from(pt in PlayerTour, where: pt.tour_id == ^tt and pt.player_id == ^player_id, select: pt.points)
    current_points = Repo.one(filter)
    updated_points = String.to_integer(points_for_player) + Decimal.to_integer(current_points)

    query = from(pt in PlayerTour, where: pt.tour_id == ^tt and pt.player_id == ^player_id, preload: [:tour, :player])
    assoc = Repo.one(query)

    assoc
    |> PlayerTour.changeset(%{points: updated_points})
    |> Repo.update()
  end

  

  @doc """
  Gets a single tour.

  Raises `Ecto.NoResultsError` if the Tour does not exist.

  ## Examples

      iex> get_tour!(123)
      %Tour{}

      iex> get_tour!(456)
      ** (Ecto.NoResultsError)

  """
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
