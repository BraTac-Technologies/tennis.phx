defmodule TennisPhx.Repo.Migrations.AddForegnKeysToPlayers do
  use Ecto.Migration

  def change do
    alter table("players") do
      add :first_player_key_id, :integer
      add :second_player_key_id, :integer
    end
  end
end
