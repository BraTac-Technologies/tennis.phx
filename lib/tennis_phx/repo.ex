defmodule TennisPhx.Repo do
  use Ecto.Repo,
    otp_app: :tennis_phx,
    adapter: Ecto.Adapters.Postgres
end
