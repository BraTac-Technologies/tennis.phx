defmodule TennisPhx.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :player1_id, :string
      add :tour_id, :string
      add :title, :string
      add :info, :string

      timestamps()
    end
  end
end
