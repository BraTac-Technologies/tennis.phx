defmodule TennisPhx.StatusesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TennisPhx.Statuses` context.
  """

  @doc """
  Generate a status.
  """
  def status_fixture(attrs \\ %{}) do
    {:ok, status} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TennisPhx.Statuses.create_status()

    status
  end
end
