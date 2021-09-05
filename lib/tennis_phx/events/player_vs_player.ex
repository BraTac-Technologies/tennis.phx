defmodule TennisPhx.Events.PlayerVsPlayer do
  use Ecto.Schema
  import Ecto.Changeset

  alias TennisPhx.Events.Tour
  alias TennisPhx.Participants.Player

  schema "player_vs_player" do

    field :tour_id, :integer
    field :player1_id, :integer
    field :player2_id, :integer
    field :player1_games, :decimal
    field :player2_games, :decimal


    timestamps()
  end

  @doc false

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:tour_id, :player1_id, :player2_id, :player1_games, :player2_games])
  end
end
