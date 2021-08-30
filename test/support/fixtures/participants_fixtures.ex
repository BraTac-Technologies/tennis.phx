defmodule TennisPhx.ParticipantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TennisPhx.Participants` context.
  """

  @doc """
  Generate a player.
  """
  def player_fixture(attrs \\ %{}) do
    {:ok, player} =
      attrs
      |> Enum.into(%{
        birthdate: ~N[2021-08-29 13:11:00],
        info: "some info",
        name: "some name",
        nickname: "some nickname"
      })
      |> TennisPhx.Participants.create_player()

    player
  end
end
