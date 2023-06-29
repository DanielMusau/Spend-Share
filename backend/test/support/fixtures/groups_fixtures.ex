defmodule ExpenseSharingApp.GroupsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ExpenseSharingApp.Groups` context.
  """

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> ExpenseSharingApp.Groups.create_group()

    group
  end
end
