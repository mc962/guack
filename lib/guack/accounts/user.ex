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
    field(:token, :string)

    timestamps()
  end

  def store_token_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:token])
  end

  def registration_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username, :first_name, :last_name, :password, :password_confirmation])
    |> validate_required([:username, :password, :password_confirmation, :email])
    |> validate_length(:username, min: 3, max: 15)
    |> validate_length(:password, min: 8)
    |> validate_format(:email, ~r/@/)
    |> validate_confirmation(:password)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    # check if changeset is valid
    case changeset do
      # if changeset is valid, send the password value to be hashed/salted
      # stick password hash into changeset
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} -> put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      # if changeset is not valid, discard useless params and just return the changeset for future use and validation
      _ -> changeset
    end
  end
end
