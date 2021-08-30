defmodule TennisPhx.Events.Tour do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tours" do
    field :date, :naive_datetime
    field :info, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(tour, attrs) do
    tour
    |> cast(attrs, [:title, :info, :date])
    |> validate_required([:title, :info, :date])
  end
end
