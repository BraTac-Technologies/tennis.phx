defmodule TennisPhx.Participants.Player do
  use Ecto.Schema
  import Ecto.Changeset

  alias TennisPhx.Events.Tour
  alias TennisPhx.Matches.Match

  schema "players" do
    field :birthdate, :naive_datetime
    field :info, :string
    field :name, :string
    field :nickname, :string
    field :points, :integer
    field :hand, :string



    timestamps()

    many_to_many(
      :tours,
      Tour,
      join_through: "player_tour",
      on_replace: :delete
    )
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :nickname, :info, :birthdate, :points, :hand])
    |> validate_required([:name])
  end
end
