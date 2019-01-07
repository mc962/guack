defmodule Guack.Repo do
  use Ecto.Repo,
    otp_app: :guack,
    adapter: Ecto.Adapters.Postgres
end
