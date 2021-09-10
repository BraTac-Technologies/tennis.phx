defmodule TennisPhx.Repo.Migrations.ChangePlayerIdsMatches do
  use Ecto.Migration

  def change do
    alter table("matches") do
      remove(:player1_id)
      remove(:player2_id)
      add :player1_id, :integer
      add :player2_id, :integer
    end

  end
end
