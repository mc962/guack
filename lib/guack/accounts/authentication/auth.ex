defmodule Guack.Auth do
    require Ecto.Query

    import Plug.Conn

    alias Guack.Authentication.Guardian
    alias Comeonin.Bcrypt
    alias Guack.Accounts.User
    alias Guack.Repo

    def authenticate_user(username, given_password) do
        query = Ecto.Query.from(u in User, where: u.username == ^username)

        Repo.one(query)
        |> check_password(given_password)
    end

    def store_token(%User{} = user, token) do
        user
        |> User.store_token_changeset(%{token: token})
        |> Repo.update
    end

    def revoke_token(user, token) do
        # update token on the database side, without returning it to the frontend
        # effectively wipes access to the account from the client
        store_token(user, token)
    end

    def login(conn, user) do
        conn
        |> Guardian.Plug.sign_in(user)
        |> assign(:current_user, user)
        |> put_user_token(user)
    end

    def logout(conn, user) do
        conn
        |> Guardian.Plug.sign_out(user)
    end

    defp check_password(user, given_password) do
        case Bcrypt.checkpw(given_password, user.password_hash) do
            true -> {:ok, user}
            false -> {:error, "Incorrect username or password"}
        end
    end

    defp put_user_token(conn, user) do
        token = Phoenix.Token.sign(conn, "user socket", user.id)

        conn
        |> assign(:user_token, token)
    end
end
