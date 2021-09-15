defmodule TennisPhx.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add(:tour_id, references(:tours, on_delete: :delete_all))
      add(:player1_id, references(:players, on_delete: :delete_all))
      add(:player2_id, references(:players, on_delete: :delete_all))
      add :starting_datetime, :naive_datetime
      add :score, :map
      add(:location_id, references(:locations, on_delete: :delete_all))
      add(:phase_id, references(:phases, on_delete: :delete_all))
      add(:status_id, references(:statuses, on_delete: :delete_all))
      add(:player_unit_id, references(:player_units, on_delete: :delete_all))

      timestamps()
    end
  end
end
