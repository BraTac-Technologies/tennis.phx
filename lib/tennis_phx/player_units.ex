defmodule TennisPhx.PlayerUnits do
  @moduledoc """
  The PlayerUnits context.
  """

  import Ecto.Query, warn: false
  alias TennisPhx.Repo

  alias TennisPhx.PlayerUnits.Player_unit

  @doc """
  Returns the list of player_units.

  ## Examples

      iex> list_player_units()
      [%Player_unit{}, ...]

  """
  def list_player_units do
    Repo.all(Player_unit)
  end

  @doc """
  Gets a single player_unit.

  Raises `Ecto.NoResultsError` if the Player unit does not exist.

  ## Examples

      iex> get_player_unit!(123)
      %Player_unit{}

      iex> get_player_unit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player_unit!(id), do: Repo.get!(Player_unit, id)

  @doc """
  Creates a player_unit.

  ## Examples

      iex> create_player_unit(%{field: value})
      {:ok, %Player_unit{}}

      iex> create_player_unit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player_unit(attrs \\ %{}) do
    %Player_unit{}
    |> Player_unit.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player_unit.

  ## Examples

      iex> update_player_unit(player_unit, %{field: new_value})
      {:ok, %Player_unit{}}

      iex> update_player_unit(player_unit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player_unit(%Player_unit{} = player_unit, attrs) do
    player_unit
    |> Player_unit.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a player_unit.

  ## Examples

      iex> delete_player_unit(player_unit)
      {:ok, %Player_unit{}}

      iex> delete_player_unit(player_unit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player_unit(%Player_unit{} = player_unit) do
    Repo.delete(player_unit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player_unit changes.

  ## Examples

      iex> change_player_unit(player_unit)
      %Ecto.Changeset{data: %Player_unit{}}

  """
  def change_player_unit(%Player_unit{} = player_unit, attrs \\ %{}) do
    Player_unit.changeset(player_unit, attrs)
  end
end
