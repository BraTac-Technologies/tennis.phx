defmodule TennisPhx.Repo.Migrations.RenamePlayersToPlural do
  use Ecto.Migration

  def change do
    alter table("matches") do
      remove(:first_player)
      remove(:second_player)
      add(:first_players, references(:players, on_delete: :delete_all))
      add(:second_players, references(:players, on_delete: :delete_all))
    end
  end
end
