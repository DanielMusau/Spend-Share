defmodule ExpenseSharingApp.GroupUsersTest do
  use ExpenseSharingApp.DataCase

  alias ExpenseSharingApp.GroupUsers

  describe "group_users" do
    alias ExpenseSharingApp.GroupUsers.GroupUser

    import ExpenseSharingApp.GroupUsersFixtures

    @invalid_attrs %{}

    test "list_group_users/0 returns all group_users" do
      group_user = group_user_fixture()
      assert GroupUsers.list_group_users() == [group_user]
    end

    test "get_group_user!/1 returns the group_user with given id" do
      group_user = group_user_fixture()
      assert GroupUsers.get_group_user!(group_user.id) == group_user
    end

    test "create_group_user/1 with valid data creates a group_user" do
      valid_attrs = %{}

      assert {:ok, %GroupUser{} = group_user} = GroupUsers.create_group_user(valid_attrs)
    end

    test "create_group_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GroupUsers.create_group_user(@invalid_attrs)
    end

    test "update_group_user/2 with valid data updates the group_user" do
      group_user = group_user_fixture()
      update_attrs = %{}

      assert {:ok, %GroupUser{} = group_user} = GroupUsers.update_group_user(group_user, update_attrs)
    end

    test "update_group_user/2 with invalid data returns error changeset" do
      group_user = group_user_fixture()
      assert {:error, %Ecto.Changeset{}} = GroupUsers.update_group_user(group_user, @invalid_attrs)
      assert group_user == GroupUsers.get_group_user!(group_user.id)
    end

    test "delete_group_user/1 deletes the group_user" do
      group_user = group_user_fixture()
      assert {:ok, %GroupUser{}} = GroupUsers.delete_group_user(group_user)
      assert_raise Ecto.NoResultsError, fn -> GroupUsers.get_group_user!(group_user.id) end
    end

    test "change_group_user/1 returns a group_user changeset" do
      group_user = group_user_fixture()
      assert %Ecto.Changeset{} = GroupUsers.change_group_user(group_user)
    end
  end
end
