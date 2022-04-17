defmodule PaginateSample.Repo do
  use Ecto.Repo,
    otp_app: :paginate_sample,
    adapter: Ecto.Adapters.Postgres
end
