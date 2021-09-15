defmodule TennisPhx.Phases do
  @moduledoc """
  The Phases context.
  """

  import Ecto.Query, warn: false
  alias TennisPhx.Repo

  alias TennisPhx.Phases.Phase

  @doc """
  Returns the list of phases.

  ## Examples

      iex> list_phases()
      [%Phase{}, ...]

  """
  def list_phases do
    Repo.all(Phase)
  end

  @doc """
  Gets a single phase.

  Raises `Ecto.NoResultsError` if the Phase does not exist.

  ## Examples

      iex> get_phase!(123)
      %Phase{}

      iex> get_phase!(456)
      ** (Ecto.NoResultsError)

  """
  def get_phase!(id), do: Repo.get!(Phase, id)

  @doc """
  Creates a phase.

  ## Examples

      iex> create_phase(%{field: value})
      {:ok, %Phase{}}

      iex> create_phase(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_phase(attrs \\ %{}) do
    %Phase{}
    |> Phase.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a phase.

  ## Examples

      iex> update_phase(phase, %{field: new_value})
      {:ok, %Phase{}}

      iex> update_phase(phase, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_phase(%Phase{} = phase, attrs) do
    phase
    |> Phase.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a phase.

  ## Examples

      iex> delete_phase(phase)
      {:ok, %Phase{}}

      iex> delete_phase(phase)
      {:error, %Ecto.Changeset{}}

  """
  def delete_phase(%Phase{} = phase) do
    Repo.delete(phase)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking phase changes.

  ## Examples

      iex> change_phase(phase)
      %Ecto.Changeset{data: %Phase{}}

  """
  def change_phase(%Phase{} = phase, attrs \\ %{}) do
    Phase.changeset(phase, attrs)
  end
end
