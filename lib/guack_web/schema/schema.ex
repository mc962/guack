defmodule Guack.Web.Schema do
  use Absinthe.Schema
  import_types(Guack.Web.Schema.Types)

  query do
    field :accounts_users, list_of(:accounts_user) do
      resolve(&Guack.Web.Accounts.UserResolver.list_users/2)
    end

    field :accounts_user, :accounts_user do
      arg(:username, non_null(:string))
      resolve(&Guack.Web.Accounts.UserResolver.find/2)
    end
  end

  mutation do
    field :create_user, :accounts_user do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))
      arg(:password_confirmation, non_null(:string))
      arg(:email, non_null(:string))
      arg(:first_name, :string)
      arg(:last_name, :string)

      resolve(&Guack.Web.Accounts.UserResolver.create/2)
    end

    field :login, :accounts_user do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Guack.Web.Accounts.UserResolver.login/2)
    end
  end
end
