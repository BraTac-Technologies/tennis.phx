defmodule TennisPhx.Repo.Migrations.AddWinLossMatch2 do
  use Ecto.Migration

  def change do
    alter table("matches") do
      add(:winner_id, references(:players, on_delete: :delete_all))
      add(:loser_id, references(:players, on_delete: :delete_all))
    end
  end
end
