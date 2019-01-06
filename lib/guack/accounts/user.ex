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
    |> validate_required([:email, :username, :password, :password_confirmation])
    |> validate_length(:username, min: 3, max: 15)
    |> validate_length(:password, min: 8)
    |> validate_format(:email, ~r/@/)
    |> validate_confirmation(:password)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    # check if changeset is valid, if so pass in the password value into password_hash, hash/salt it, and stick it into the
    # changeset as :password_hash
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
        # if the changeset is not valid, discard the useless params and just return the changeset for future use and validation
      _ -> changeset
    end
  end
end
