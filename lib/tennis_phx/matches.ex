defmodule TennisPhx.Matches do
  @moduledoc """
  The Matches context.
  """

  import Ecto.Query, warn: false
  alias TennisPhx.Repo

  alias TennisPhx.Matches.Match
  alias TennisPhx.Events.Tour


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

  alias TennisPhx.Matches.Group

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_groups do
    Repo.all(Group)
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Group, id)

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{data: %Group{}}

  """
  def change_group(%Group{} = group, attrs \\ %{}) do
    Group.changeset(group, attrs)
  end
end
