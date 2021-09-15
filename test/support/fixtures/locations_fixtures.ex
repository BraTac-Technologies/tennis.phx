defmodule TennisPhx.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TennisPhx.Locations` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        city: "some city",
        country: "some country",
        description: "some description",
        image: "some image",
        name: "some name"
      })
      |> TennisPhx.Locations.create_location()

    location
  end
end
