defmodule TennisPhx.Repo.Migrations.CreateTours do
  use Ecto.Migration

  def change do
    create table(:tours) do
      add :title, :string
      add :info, :string
      add :date, :naive_datetime

      timestamps()
    end
  end
end
