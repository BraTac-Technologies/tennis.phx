defmodule TennisPhx.Repo.Migrations.CreatePlayerVsPlayer do
  use Ecto.Migration

  def change do
    create table(:player_vs_player) do
      add(:tour_id, references(:tours, on_delete: :delete_all))
      add(:player1_id, references(:players, on_delete: :delete_all))
      add(:player2_id, references(:players, on_delete: :delete_all))
      add(:player1_games, :decimal)
      add(:player2_games, :decimal)
      
      timestamps()
    end



  end
end
