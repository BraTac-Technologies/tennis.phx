defmodule TennisPhx.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias TennisPhx.Participants.Player
  alias TennisPhx.Events.Tour
  alias TennisPhx.Phases.Phase

  schema "groups" do

    belongs_to :player1, Player
    belongs_to :player2, Player
    belongs_to :player3, Player
    belongs_to :player4, Player
    belongs_to :player5, Player
    belongs_to :player6, Player
    belongs_to :player7, Player
    belongs_to :player8, Player
    belongs_to :tour, Tour
    belongs_to :phase, Phase

    field :info, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:phase_id, :player1_id, :player2_id, :player3_id, :player4_id, :player5_id, :player6_id, :player7_id, :player8_id, :tour_id, :info, :title])
    # |> validate_required([:player1_id, :tour_id, :title, :info])
  end
end
