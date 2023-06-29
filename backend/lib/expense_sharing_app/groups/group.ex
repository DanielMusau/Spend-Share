defmodule ExpenseSharingApp.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExpenseSharingApp.GroupUsers.GroupUser
  alias ExpenseSharingApp.Expenses.Expense

  schema "groups" do
    field :name, :string

    has_many :group_users, GroupUser
    has_many :expenses, Expense

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
