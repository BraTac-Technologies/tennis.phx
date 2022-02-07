defmodule TennisPhx.TagsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TennisPhx.Tags` context.
  """

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        name: "some name",
        player_id: "some player_id",
        points: 42
      })
      |> TennisPhx.Tags.create_tag()

    tag
  end
end
