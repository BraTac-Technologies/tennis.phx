defmodule TennisPhx.Repo.Migrations.CreateNewPlayerFields do
  use Ecto.Migration

  def change do
    alter table("matches") do
      add(:first_players, references(:players, on_delete: :delete_all))
      add(:second_players, references(:players, on_delete: :delete_all))
    end
  end
end
