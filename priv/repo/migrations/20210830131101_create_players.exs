defmodule TennisPhx.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :nickname, :string
      add :info, :string
      add :birthdate, :naive_datetime

      timestamps()
    end
  end
end
