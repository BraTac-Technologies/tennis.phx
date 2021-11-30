defmodule TennisPhx.Repo.Migrations.AddPointsToPlayer do
  use Ecto.Migration

  def change do
    alter table("matches") do
      add :points, :integer
    end

  end
end
