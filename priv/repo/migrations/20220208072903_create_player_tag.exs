defmodule TennisPhx.Repo.Migrations.CreatePlayerTag do
  use Ecto.Migration

  def change do
  create table(:player_tag) do
    add(:player_id, references(:players, on_delete: :delete_all))
    add(:tag_id, references(:tags, on_delete: :delete_all))
    add(:points, :decimal)
    timestamps()
  end

  create unique_index(:player_tag, [:player_id, :tag_id], name: :player_tag_unique_index)

  end
end
