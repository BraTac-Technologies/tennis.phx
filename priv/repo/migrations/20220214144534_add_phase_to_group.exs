defmodule TennisPhx.Repo.Migrations.AddPhaseToGroup do
  use Ecto.Migration

  def change do
    alter table(:groups) do
      add(:phase_id, references(:phases, on_delete: :delete_all))
    end
  end
end
