defmodule Guack.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Guack.Accounts.User

  schema "users" do
    field(:username, :string, required: true)
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)
    field(:password_hash, :string)
    field(:email, :string, required: true)
    field(:first_name, :string)
    field(:last_name, :string)

    timestamps()
  end

  def registration_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username, :password])
    |> validate_required([:username, :password, :password_confirmation, :email])
    |> validate_length(:username, min: 3, max: 10)
    |> validate_length(:password, min: 8)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
