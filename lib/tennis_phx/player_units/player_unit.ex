defmodule TennisPhx.PlayerUnits.Player_unit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player_units" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(player_unit, attrs) do
    player_unit
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
