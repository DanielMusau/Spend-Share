defmodule ExpenseSharingApp.Expenses.Expense do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExpenseSharingApp.Users.User
  alias ExpenseSharingApp.Groups.Group

  schema "expenses" do
    field :amount, :integer
    field :name, :string

    belongs_to :user, User
    belongs_to :group, Group

    timestamps()
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:name, :amount, :user_id, :group_id])
    |> validate_required([:name, :amount, :user_id, :group_id])
  end
end
