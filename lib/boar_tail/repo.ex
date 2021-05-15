defmodule BoarTail.Repo do
  use Ecto.Repo,
    otp_app: :boar_tail,
    adapter: Ecto.Adapters.Postgres
end
