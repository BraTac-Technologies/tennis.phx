defmodule TennisPhx.Events.Tour do
  use Ecto.Schema
  import Ecto.Changeset

  alias TennisPhx.Participants.Player

  schema "tours" do
    field :date, :naive_datetime
    field :info, :string
    field :title, :string

    timestamps()

    many_to_many(
      :players,
      Player,
      join_through: "player_tour",
      on_replace: :delete
    )
  end

  @doc false
  def changeset(tour, attrs) do
    tour
    |> cast(attrs, [:title, :info, :date])
    |> validate_required([:title, :info, :date])
  end
end
