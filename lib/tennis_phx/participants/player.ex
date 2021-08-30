defmodule TennisPhx.Participants.Player do
  use Ecto.Schema
  import Ecto.Changeset

  alias TennisPhx.Events.Tour

  schema "players" do
    field :birthdate, :naive_datetime
    field :info, :string
    field :name, :string
    field :nickname, :string

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
    |> cast(attrs, [:name, :nickname, :info, :birthdate])
    |> validate_required([:name, :nickname, :info, :birthdate])
  end
end
