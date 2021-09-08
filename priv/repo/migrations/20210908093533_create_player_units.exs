defmodule TennisPhx.Repo.Migrations.CreatePlayerUnits do
  use Ecto.Migration

  def change do
    create table(:player_units) do
      add :name, :string

      timestamps()
    end
  end
end
