defmodule ExpenseSharingApp.GroupUsers.GroupUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExpenseSharingApp.Users.User
  alias ExpenseSharingApp.Groups.Group

  schema "group_users" do

    belongs_to :user, User
    belongs_to :group, Group

    timestamps()
  end

  @doc false
  def changeset(group_user, attrs) do
    group_user
    |> cast(attrs, [:user_id, :group_id])
    |> validate_required([:user_id, :group_id ])
  end
end
