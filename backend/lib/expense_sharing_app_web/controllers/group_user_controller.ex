defmodule ExpenseSharingAppWeb.GroupUserController do
  use ExpenseSharingAppWeb, :controller

  alias ExpenseSharingApp.GroupUsers
  alias ExpenseSharingApp.GroupUsers.GroupUser

  action_fallback ExpenseSharingAppWeb.FallbackController

  def index(conn, _params) do
    group_users = GroupUsers.list_group_users()
    render(conn, :index, group_users: group_users)
  end

  def create(conn, group_user_params) do
    with {:ok, %GroupUser{} = group_user} <- GroupUsers.create_group_user(group_user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/group_users/#{group_user}")
      |> render(:show, group_user: group_user)
    end
  end

  def show(conn, %{"id" => id}) do
    group_user = GroupUsers.get_group_user!(id)
    render(conn, :show, group_user: group_user)
  end

  def update(conn, %{"id" => id, "group_user" => group_user_params}) do
    group_user = GroupUsers.get_group_user!(id)

    with {:ok, %GroupUser{} = group_user} <- GroupUsers.update_group_user(group_user, group_user_params) do
      render(conn, :show, group_user: group_user)
    end
  end

  def delete(conn, %{"id" => id}) do
    group_user = GroupUsers.get_group_user!(id)

    with {:ok, %GroupUser{}} <- GroupUsers.delete_group_user(group_user) do
      send_resp(conn, :no_content, "")
    end
  end
end
