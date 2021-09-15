defmodule TennisPhx.Repo.Migrations.RemoveIdsFromPlayersMatch do
  use Ecto.Migration

  def change do
    alter table("matches") do
      remove(:first_player_id)
      remove(:second_player_id)
      add(:first_player, references(:players, on_delete: :delete_all))
      add(:second_player, references(:players, on_delete: :delete_all))
    end
  end
end
