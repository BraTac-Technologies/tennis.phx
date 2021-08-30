defmodule TennisPhx.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TennisPhx.Events` context.
  """

  @doc """
  Generate a tour.
  """
  def tour_fixture(attrs \\ %{}) do
    {:ok, tour} =
      attrs
      |> Enum.into(%{
        date: ~N[2021-08-29 12:36:00],
        info: "some info",
        title: "some title"
      })
      |> TennisPhx.Events.create_tour()

    tour
  end
end
