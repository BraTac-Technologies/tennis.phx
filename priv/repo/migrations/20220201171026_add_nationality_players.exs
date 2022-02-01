defmodule TennisPhx.Repo.Migrations.AddNationalityPlayers do
  use Ecto.Migration

  def change do
    alter table(:players) do
      add :country, :string
      add :city, :string
    end
  end
end
