defmodule TennisPhx.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  alias TennisPhx.Participants.Player

  schema "tags" do
    field :name, :string
    belongs_to :player, Player
    field :points, :integer

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
    |> cast(attrs, [:name, :player_id, :points])
  end
end
