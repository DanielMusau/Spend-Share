defmodule ExpenseSharingApp.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :name, :string
      add :amount, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :group_id, references(:groups, on_delete: :nothing)

      timestamps()
    end

    create index(:expenses, [:user_id])
    create index(:expenses, [:group_id])
  end
end
