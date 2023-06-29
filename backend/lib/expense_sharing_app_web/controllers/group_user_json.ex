defmodule ExpenseSharingAppWeb.GroupUserJSON do
  alias ExpenseSharingApp.GroupUsers.GroupUser

  @doc """
  Renders a list of group_users.
  """
  def index(%{group_users: group_users}) do
    %{data: for(group_user <- group_users, do: data(group_user))}
  end

  @doc """
  Renders a single group_user.
  """
  def show(%{group_user: group_user}) do
    %{data: data(group_user)}
  end

  defp data(%GroupUser{} = group_user) do
    %{
      id: group_user.id
    }
  end
end
