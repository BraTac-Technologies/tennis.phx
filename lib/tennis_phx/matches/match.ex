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


    has_many :first_players, Player, foreign_key: :first_player_key_id
    has_many :second_players, Player, foreign_key: :second_player_key_id

    field :starting_datetime, :date
    belongs_to :location, Location
    belongs_to :phase, Phase
    belongs_to :status, Status
    belongs_to :player_unit, PlayerUnit
    belongs_to :tour, Tour

    embeds_one :score, Score, on_replace: :update


    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:tour_id, :first_players, :second_players, :starting_datetime, :location_id, :phase_id, :status_id, :player_unit_id])
    |> validate_required([:tour_id, :first_players, :second_players, :location_id, :phase_id, :player_unit_id])
  end
end
