defmodule TennisPhx.Matches.Match do
  use Ecto.Schema
  import Ecto.Changeset

  alias TennisPhx.Events.Tour
  alias TennisPhx.Participants.Player
  alias TennisPhx.Locations.Location
  alias TennisPhx.Phases.Phase
  alias TennisPhx.Statuses.Status
  alias TennisPhx.PlayerUnits.Player_unit

  schema "matches" do
    belongs_to :tour, Tour
    belongs_to :player, Player

    field :starting_datetime, :naive_datetime
    field :score, :map

    belongs_to :location, Location
    belongs_to :phase, Phase
    belongs_to :status, Status
    belongs_to :player_unit, PlayerUnit


    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:tour_id, :player1_id, :player2_id, :starting_datetime, :score, :location_id, :phase_id, :status_id, :player_unit_id])
    |> validate_required([:tour_id, :player1_id, :player2_id, :starting_datetime, :score, :location_id, :phase_id, :status_id, :player_unit_id])
  end
end
