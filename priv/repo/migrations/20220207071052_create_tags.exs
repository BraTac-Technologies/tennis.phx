defmodule TennisPhx.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string
      add :player_id, :string
      add :points, :integer

      timestamps()
    end
  end
end
