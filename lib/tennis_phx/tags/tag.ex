defmodule TennisPhx.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  alias TennisPhx.Participants.Player
  alias TennisPhx.Locations.Location

  schema "tags" do
    field :name, :string
    belongs_to :player, Player
    field :points, :integer
    field :info, :string
    belongs_to :location, Location

    timestamps()

    many_to_many(
      :players,
      Player,
      join_through: "player_tag",
      on_replace: :delete
    )

  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :info, :location_id])
  end
end
