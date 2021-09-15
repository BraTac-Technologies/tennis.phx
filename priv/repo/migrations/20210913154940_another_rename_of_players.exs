defmodule TennisPhx.Repo.Migrations.AnotherRenameOfPlayers do
  use Ecto.Migration

  def change do
    alter table("matches") do
      remove(:first_players)
      remove(:second_players)
      add(:first_player_id, references(:players, on_delete: :delete_all))
      add(:second_player_id, references(:players, on_delete: :delete_all))
    end
  end
end
