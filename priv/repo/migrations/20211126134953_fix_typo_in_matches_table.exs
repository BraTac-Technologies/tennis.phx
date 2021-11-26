defmodule TennisPhx.Repo.Migrations.FixTypoInMatchesTable do
  use Ecto.Migration

  def change do
    alter table("matches") do
      remove :points, :integer
    end
    
    alter table("players") do
      add :points, :integer
    end

  end
end
