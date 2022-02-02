defmodule TennisPhx.Events.Tour do
  use Ecto.Schema
  import Ecto.Changeset

  alias TennisPhx.Participants.Player
  alias TennisPhx.Statuses.Status
  alias TennisPhx.Locations.Location

  schema "tours" do
    field :date, :naive_datetime
    field :info, :string
    field :title, :string
    belongs_to :winner, Player
    belongs_to :status, Status
    belongs_to :location, Location

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
    |> cast(attrs, [:title, :info, :date, :status_id, :location_id, :winner_id])
    |> validate_required([:title, :date])
  end
end
