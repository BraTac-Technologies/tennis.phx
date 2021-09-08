defmodule TennisPhx.Statuses.Status do
  use Ecto.Schema
  import Ecto.Changeset

  schema "statuses" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(status, attrs) do
    status
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
