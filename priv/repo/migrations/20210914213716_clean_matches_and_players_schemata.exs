defmodule TennisPhx.Repo.Migrations.CleanMatchesAndPlayersSchemata do
  use Ecto.Migration

  def change do
    alter table("matches") do
      remove(:first_player_key_id)
      remove(:second_player_key_id)
    end
    alter table("players") do
      remove(:first_player_key_id)
      remove(:second_player_key_id)
    end
  end
end
