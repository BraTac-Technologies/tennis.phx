defmodule TennisPhx.Repo.Migrations.AddUniqueIndexPlayerVPlayer do
  use Ecto.Migration

  def change do
    create unique_index(:player_vs_player, [:player1_id, :player2_id, :tour_id], name: :player_vs_player_unique_index)
  end
end
