defmodule TennisPhx.Matches.Match do
  use Ecto.Schema
  import Ecto.Changeset

  alias TennisPhx.Events.Tour
  alias TennisPhx.Participants.Player
  alias TennisPhx.Locations.Location
  alias TennisPhx.Phases.Phase
  alias TennisPhx.Statuses.Status
  alias TennisPhx.PlayerUnits.Player_unit
  alias TennisPhx.Matches.Score

  schema "matches" do
    belongs_to :tour, Tour



    field :starting_datetime, :date
    field :player1_id, :integer
    field :player2_id, :integer

    belongs_to :location, Location
    belongs_to :phase, Phase
    belongs_to :status, Status
    belongs_to :player_unit, PlayerUnit

    embeds_one :score, Score, on_replace: :update


    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:tour_id, :player1_id, :player2_id, :starting_datetime, :location_id, :phase_id, :status_id, :player_unit_id])
    |> validate_required([:tour_id, :player1_id, :player2_id, :location_id, :phase_id, :player_unit_id])
  end
end
