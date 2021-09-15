defmodule TennisPhx.Repo.Migrations.AddForegnKeys do
  use Ecto.Migration

  def change do
    alter table("matches") do
      add :first_player_key_id, :integer
      add :second_player_key_id, :integer
    end

  end
end
