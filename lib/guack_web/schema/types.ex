defmodule Guack.Web.Schema.Types do
  use Absinthe.Schema.Notation
  # use Absinthe.Ecto, repo: Guack.Repo

  object :accounts_user do
    field(:id, :id)
    field(:username, :string)
    field(:first_name, :string)
    field(:last_name, :string)
  end
end
