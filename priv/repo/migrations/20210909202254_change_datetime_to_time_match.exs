defmodule TennisPhx.Repo.Migrations.ChangeDatetimeToTimeMatch do
  use Ecto.Migration

  def change do
    alter table("matches") do
      remove(:starting_datetime)
      add :starting_datetime, :date
    end

  end
end
