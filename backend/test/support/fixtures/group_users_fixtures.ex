defmodule ExpenseSharingApp.GroupUsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ExpenseSharingApp.GroupUsers` context.
  """

  @doc """
  Generate a group_user.
  """
  def group_user_fixture(attrs \\ %{}) do
    {:ok, group_user} =
      attrs
      |> Enum.into(%{

      })
      |> ExpenseSharingApp.GroupUsers.create_group_user()

    group_user
  end
end
