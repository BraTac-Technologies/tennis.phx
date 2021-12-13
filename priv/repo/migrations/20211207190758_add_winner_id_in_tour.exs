defmodule TennisPhx.Repo.Migrations.AddWinnerIdInTour do
  use Ecto.Migration

  def change do
    alter table("tours") do
      add(:winner_id, references(:players, on_delete: :delete_all))
    end
  end
end
