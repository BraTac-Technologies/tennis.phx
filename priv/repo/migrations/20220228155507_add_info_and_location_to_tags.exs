defmodule TennisPhx.Repo.Migrations.AddInfoAndLocationToTags do
  use Ecto.Migration

  def change do
    alter table(:tags) do
      add(:location_id, references(:locations, on_delete: :delete_all))
      add :info, :string
    end
  end
end
