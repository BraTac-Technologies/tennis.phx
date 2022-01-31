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

    belongs_to :first_player, Player
    belongs_to :second_player, Player
    belongs_to :winner, Player
    belongs_to :loser, Player

    field :starting_datetime, :date
    field :games_for_first_player, :integer
    field :games_for_second_player, :integer


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
    |> cast(attrs, [:tour_id, :first_player_id, :second_player_id, :starting_datetime, :location_id, :phase_id, :status_id, :player_unit_id, :winner_id, :games_for_first_player, :games_for_second_player])
    |> validate_required([:tour_id, :phase_id])
    |> cast_embed(:score)

  end
end
