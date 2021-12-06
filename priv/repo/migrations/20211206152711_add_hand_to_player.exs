defmodule TennisPhx.Repo.Migrations.AddHandToPlayer do
  use Ecto.Migration

  def change do
    alter table("players") do
      add :hand, :string
    end

  end
end
