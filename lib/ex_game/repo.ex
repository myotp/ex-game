defmodule ExGame.Repo do
  use Ecto.Repo,
    otp_app: :ex_game,
    adapter: Ecto.Adapters.Postgres
end
