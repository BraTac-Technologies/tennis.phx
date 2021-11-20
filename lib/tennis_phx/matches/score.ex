defmodule TennisPhx.Matches.Score do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :game1_for_first_player, :integer
    field :game1_for_second_player, :integer
    field :game2_for_first_player, :integer
    field :game2_for_second_player, :integer
    field :game3_for_first_player, :integer
    field :game3_for_second_player, :integer
    field :game4_for_first_player, :integer
    field :game4_for_second_player, :integer
    field :game5_for_first_player, :integer
    field :game5_for_second_player, :integer
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:game1_for_first_player, :game1_for_second_player, :game2_for_first_player, :game2_for_second_player, :game3_for_first_player, :game3_for_second_player, :game4_for_first_player, :game4_for_second_player, :game5_for_first_player, :game5_for_second_player])
    |> validate_required([])
  end
end
