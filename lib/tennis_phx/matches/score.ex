defmodule TennisPhx.Matches.Score do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :game1_for_first_player, :integer
    field :game1_for_second_player, :integer
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:game1_for_first_player, :game1_for_second_player])
    |> validate_required([])
  end
end
