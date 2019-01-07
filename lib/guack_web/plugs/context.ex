defmodule Guack.Context do
    @behaviour Plug

    import Plug.Conn
    import Ecto.Query, only: [where: 2]

    alias Guack.Repo
    alias Guack.Accounts.User

    def init(opts), do: opts

    def call(conn, _) do
        case build_context(conn) do
            {:ok, context} -> put_private(conn, :absinthe, %{context: context})
            _ -> conn
        end
    end

    defp build_context(conn) do
        with ["bearer " <> token] <- get_req_header(conn, "authorization"),
             {:ok, current_user} <- authenticate(token) do
                {:ok, %{current_user: current_user, token: token}}
            end
    end

    defp authenticate(token) do
        User
        |> where(token: ^token)
        |> Repo.one()
        |> case do
            nil -> {:error, "Invalid authentication token"}
            user -> {:ok, user}
        end
    end
end
