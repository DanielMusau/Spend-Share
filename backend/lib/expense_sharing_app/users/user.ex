defmodule ExpenseSharingApp.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExpenseSharingApp.GroupUsers.GroupUser
  alias ExpenseSharingApp.Expenses.Expense

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :group_users, GroupUser
    has_many :expenses, Expense

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email, name: :uidx_users_email, message: "Email already taken")
    |> hash_password()
    |> case_name()
    |> case_email()
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(
          changeset,
          :password_hash,
          Bcrypt.Base.hash_password(pass, Bcrypt.gen_salt(12, true))
        )

      _ ->
        changeset
    end
  end

  defp case_name(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{name: auth_name}} ->
        put_change(
          changeset,
          :name,
          Recase.to_title(auth_name)
        )

      _ ->
        changeset
    end
  end

  defp case_email(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{email: auth_email}} ->
        put_change(
          changeset,
          :email,
          String.downcase(auth_email)
        )

      _ ->
        changeset
    end
  end
end
