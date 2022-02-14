defmodule TennisPhx.GroupsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TennisPhx.Groups` context.
  """

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{
        info: "some info",
        player1_id: "some player1_id",
        title: "some title",
        tour_id: "some tour_id"
      })
      |> TennisPhx.Groups.create_group()

    group
  end
end
