defmodule Guack.Accounts do
  @moduledoc """
  The Accounts context
  """

  import Ecto.Query, warn: false
  alias Guack.Repo

  alias Guack.Accounts.User

  # TODO these methods may be redundant with graphql

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def list_users do
    # TODO paginate/limit this query if users list gets too big
    User
    |> Repo.all()
  end

  def get_user(id) do
    User
    |> Repo.get(id)
  end

  def get_user_by_username(username) do
    User
    |> Repo.get_by(username: username)
  end

  def change_user_registration(%User{} = user) do
    User.registration_changeset(user, %{})
  end
end

