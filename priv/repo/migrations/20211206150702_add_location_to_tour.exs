defmodule TennisPhx.Repo.Migrations.AddLocationToTour do
  use Ecto.Migration

  def change do
    alter table("tours") do
      add(:location_id, references(:locations, on_delete: :delete_all))
    end
  end
end
