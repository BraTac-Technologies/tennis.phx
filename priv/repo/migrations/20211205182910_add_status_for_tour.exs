defmodule TennisPhx.Repo.Migrations.AddStatusForTour do
  use Ecto.Migration

  def change do
    alter table("tours") do
      add(:status_id, references(:statuses, on_delete: :delete_all))
    end

  end
end
