defmodule TennisPhx.Matches.Group do
  use Ecto.Schema
  import Ecto.Changeset

  alias TennisPhx.Events.Tour
  alias TennisPhx.Participants.Player

  schema "groups" do

    belongs_to :tour, Tour

    belongs_to :player1, Player
    belongs_to :player2, Player
    belongs_to :player3, Player
    belongs_to :player4, Player
    belongs_to :player5, Player
    belongs_to :player6, Player
    belongs_to :player7, Player
    belongs_to :player8, Player

    field :title, :string
    field :stage, :string

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:title, :stage, :tour_id, :player1_id, :player2_id, :player3_id, :player4_id, :player5_id, :player6_id, :player7_id, :player8_id])
    |> validate_required([:name])
  end
end
