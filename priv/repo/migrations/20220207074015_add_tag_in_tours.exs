defmodule TennisPhx.Repo.Migrations.AddTagInTours do
  use Ecto.Migration

  def change do
    alter table(:tours) do
      add(:tag_id, references(:tags, on_delete: :delete_all))
    end
  end
end
