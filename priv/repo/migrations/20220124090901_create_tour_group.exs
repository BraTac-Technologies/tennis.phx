defmodule TennisPhx.Repo.Migrations.CreateTourGroup do
  use Ecto.Migration

  def change do
    create table(:tour_group) do
      add(:tour_id, references(:tours, on_delete: :delete_all))
      add :title, :string
      add :stage, :string
      add(:player1_id, references(:players, on_delete: :delete_all))
      add(:player2_id, references(:players, on_delete: :delete_all))
      add(:player3_id, references(:players, on_delete: :delete_all))
      add(:player4_id, references(:players, on_delete: :delete_all))
      add(:player5_id, references(:players, on_delete: :delete_all))
      add(:player6_id, references(:players, on_delete: :delete_all))
      add(:player7_id, references(:players, on_delete: :delete_all))
      add(:player8_id, references(:players, on_delete: :delete_all))

      timestamps()
    end
  end
end
