defmodule TennisPhx.PlayerUnitsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TennisPhx.PlayerUnits` context.
  """

  @doc """
  Generate a player_unit.
  """
  def player_unit_fixture(attrs \\ %{}) do
    {:ok, player_unit} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TennisPhx.PlayerUnits.create_player_unit()

    player_unit
  end
end
