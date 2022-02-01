defmodule TennisPhx.Repo.Migrations.AddAvatarToPlayers do
  use Ecto.Migration

  def change do
    alter table(:players) do
      add :avatar, :string
    end
  end
end
