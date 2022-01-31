defmodule TennisPhx.Repo.Migrations.AddGamesInMatches do
  use Ecto.Migration

  def change do
    alter table("matches") do
      add :games_for_first_player, :integer
      add :games_for_second_player, :integer
    end
  end
end
