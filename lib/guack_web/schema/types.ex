defmodule Guack.Web.Schema.Types do
    use Absinthe.Schema.Notation

    object :accounts_user do
        field(:id, :id)
        field(:username, :string)
        field(:first_name, :string)
        field(:last_name, :string)
        field(:email, :string)
        field(:password, :string)
        field(:password_confirmation, :string)
    end
end