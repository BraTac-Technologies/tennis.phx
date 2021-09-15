defmodule TennisPhx.Repo.Migrations.CreatePhases do
  use Ecto.Migration

  def change do
    create table(:phases) do
      add :name, :string

      timestamps()
    end
  end
end
