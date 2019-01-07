defmodule Guack.Web.Accounts.UserResolver do
    alias Guack.Accounts

    import Guack.Auth

    def list_users(_args, %{context: %{current_user: _current_user}}) do
        {:ok, Accounts.list_users()}
    end

    def list_users(_args, _info) do
        {:error, "Not Allowed"}
    end

    def find(%{username: username}, _info) do
        case Accounts.get_user_by_username(username) do
            nil -> {:error, "User #{username} not found"}
            user -> {:ok, user}
        end
    end

    def create(params, _info) do
        case Accounts.create_user(params) do
            {:ok, user} -> user
            {:error, errors} -> errors
        end
    end

    def login(%{username: username, password: password}, _info) do
        with {:ok, user} <- authenticate_user(username, password),
             {:ok, jwt, _} <- Guack.Authentication.Guardian.encode_and_sign(user),
             {:ok, _} <- Guack.Auth.store_token(user, jwt) do
          {:ok, %{token: jwt}}
        end
    end
end
