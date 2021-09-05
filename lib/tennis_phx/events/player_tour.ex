defmodule TennisPhx.Events.PlayerTour do
  use Ecto.Schema
  import Ecto.Changeset

  alias TennisPhx.Events.Tour
  alias TennisPhx.Participants.Player

  schema "player_tour" do
    field :points, :decimal

    belongs_to :tour, Tour
    belongs_to :player, Player

    timestamps()
  end

  @doc false

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:tour_id, :player_id, :points])
    |> validate_required([:tour_id, :player_id])
  end
end
