defmodule TennisPhx.Repo.Migrations.DropTourGroup do
  use Ecto.Migration

  def change do
    drop table("tour_group")
  end
end
