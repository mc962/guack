defmodule Guack.Web.Accounts.UserResolver do
  alias Guack.Accounts

  def all(_args, _info) do
    {:ok, Accounts.list_users}
  end
end
