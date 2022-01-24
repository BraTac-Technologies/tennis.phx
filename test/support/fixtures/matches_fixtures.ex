defmodule TennisPhx.MatchesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TennisPhx.Matches` context.
  """

  @doc """
  Generate a match.
  """
  def match_fixture(attrs \\ %{}) do
    {:ok, match} =
      attrs
      |> Enum.into(%{
        location_id: "some location_id",
        phase_id: "some phase_id",
        player1_id: "some player1_id",
        player2_id: "some player2_id",
        player_unit_id: "some player_unit_id",
        score: %{},
        starting_datetime: ~N[2021-09-07 09:39:00],
        status_id: "some status_id",
        tour_id: "some tour_id"
      })
      |> TennisPhx.Matches.create_match()

    match
  end

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TennisPhx.Matches.create_group()

    group
  end
end
