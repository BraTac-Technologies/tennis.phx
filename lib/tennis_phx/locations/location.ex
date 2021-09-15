defmodule TennisPhx.Locations.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :city, :string
    field :country, :string
    field :description, :string
    field :image, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :description, :city, :country, :image])
    |> validate_required([:name, :city])
  end
end
