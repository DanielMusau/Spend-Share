defmodule ExpenseSharingApp.GroupUsers do
  @moduledoc """
  The GroupUsers context.
  """

  import Ecto.Query, warn: false
  alias ExpenseSharingApp.Repo

  alias ExpenseSharingApp.GroupUsers.GroupUser

  @doc """
  Returns the list of group_users.

  ## Examples

      iex> list_group_users()
      [%GroupUser{}, ...]

  """
  def list_group_users do
    Repo.all(GroupUser)
  end

  @doc """
  Gets a single group_user.

  Raises `Ecto.NoResultsError` if the Group user does not exist.

  ## Examples

      iex> get_group_user!(123)
      %GroupUser{}

      iex> get_group_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group_user!(id), do: Repo.get!(GroupUser, id)

  @doc """
  Creates a group_user.

  ## Examples

      iex> create_group_user(%{field: value})
      {:ok, %GroupUser{}}

      iex> create_group_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group_user(attrs \\ %{}) do
    %GroupUser{}
    |> GroupUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group_user.

  ## Examples

      iex> update_group_user(group_user, %{field: new_value})
      {:ok, %GroupUser{}}

      iex> update_group_user(group_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group_user(%GroupUser{} = group_user, attrs) do
    group_user
    |> GroupUser.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a group_user.

  ## Examples

      iex> delete_group_user(group_user)
      {:ok, %GroupUser{}}

      iex> delete_group_user(group_user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group_user(%GroupUser{} = group_user) do
    Repo.delete(group_user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group_user changes.

  ## Examples

      iex> change_group_user(group_user)
      %Ecto.Changeset{data: %GroupUser{}}

  """
  def change_group_user(%GroupUser{} = group_user, attrs \\ %{}) do
    GroupUser.changeset(group_user, attrs)
  end
end
