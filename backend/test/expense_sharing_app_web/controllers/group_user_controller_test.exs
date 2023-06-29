defmodule ExpenseSharingAppWeb.GroupUserControllerTest do
  use ExpenseSharingAppWeb.ConnCase

  import ExpenseSharingApp.GroupUsersFixtures

  alias ExpenseSharingApp.GroupUsers.GroupUser

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all group_users", %{conn: conn} do
      conn = get(conn, ~p"/api/group_users")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create group_user" do
    test "renders group_user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/group_users", group_user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/group_users/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/group_users", group_user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update group_user" do
    setup [:create_group_user]

    test "renders group_user when data is valid", %{conn: conn, group_user: %GroupUser{id: id} = group_user} do
      conn = put(conn, ~p"/api/group_users/#{group_user}", group_user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/group_users/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, group_user: group_user} do
      conn = put(conn, ~p"/api/group_users/#{group_user}", group_user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete group_user" do
    setup [:create_group_user]

    test "deletes chosen group_user", %{conn: conn, group_user: group_user} do
      conn = delete(conn, ~p"/api/group_users/#{group_user}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/group_users/#{group_user}")
      end
    end
  end

  defp create_group_user(_) do
    group_user = group_user_fixture()
    %{group_user: group_user}
  end
end
