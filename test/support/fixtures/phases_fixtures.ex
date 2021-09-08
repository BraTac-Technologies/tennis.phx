defmodule TennisPhx.PhasesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TennisPhx.Phases` context.
  """

  @doc """
  Generate a phase.
  """
  def phase_fixture(attrs \\ %{}) do
    {:ok, phase} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TennisPhx.Phases.create_phase()

    phase
  end
end
