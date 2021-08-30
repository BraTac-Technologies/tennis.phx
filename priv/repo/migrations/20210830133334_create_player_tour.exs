defmodule TennisPhx.Repo.Migrations.CreatePlayerTour do
  use Ecto.Migration

  def change do
    create table(:player_tour) do
      add(:player_id, references(:players, on_delete: :delete_all))
      add(:tour_id, references(:tours, on_delete: :delete_all))
      add(:points, :decimal)
      timestamps()
    end

    create unique_index(:player_tour, [:player_id, :tour_id], name: :player_tour_unique_index)

  end
end
