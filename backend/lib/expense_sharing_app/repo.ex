defmodule ExpenseSharingApp.Repo do
  use Ecto.Repo,
    otp_app: :expense_sharing_app,
    adapter: Ecto.Adapters.Postgres
end
