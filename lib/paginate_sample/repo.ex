defmodule PaginateSample.Repo do
  use Ecto.Repo,
    otp_app: :paginate_sample,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
