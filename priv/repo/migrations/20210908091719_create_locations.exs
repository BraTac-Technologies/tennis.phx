defmodule TennisPhx.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :description, :string
      add :city, :string
      add :country, :string
      add :image, :string

      timestamps()
    end
  end
end
