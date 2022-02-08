defmodule TennisPhx.Participants.PlayerTag do
  use Ecto.Schema
  import Ecto.Changeset

  alias TennisPhx.Tags.Tag
  alias TennisPhx.Participants.Player

  schema "player_tag" do
    field :points, :decimal, default: 0

    belongs_to :tag, Tag
    belongs_to :player, Player

    timestamps()
  end

  @doc false

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:tag_id, :player_id, :points])
    |> validate_required([:tag_id, :player_id])
    |> unique_constraint(:player_tag_unique_index, name: :player_tag_unique_index)
  end
end
