defmodule TennisPhx.Repo.Migrations.RefactorPlayerIdsMatches do
  use Ecto.Migration

  def change do
    alter table("matches") do
      remove(:player1_id)
      remove(:player2_id)
    end
  end
end
