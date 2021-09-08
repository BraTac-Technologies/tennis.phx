defmodule TennisPhx.Phases.Phase do
  use Ecto.Schema
  import Ecto.Changeset

  schema "phases" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(phase, attrs) do
    phase
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
