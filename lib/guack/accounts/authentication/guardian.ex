defmodule Guack.Authentication.Guardian do
    use Guardian, otp_app: :guack

    alias Guack.Accounts

    def subject_for_token(user, _claims) do
        sub = to_string(user.id)
        {:ok, sub}
    end

    # TODO add better error handling for subject_for_token
    # def subject_for_token(_, _) do
    #     {:error, :reason_for_error}
    # end

    def resource_from_claims(claims) do
        id = claims["sub"]
        user = Accounts.get_user(id)
        {:ok, user}
    end

    # TODO add better error handling for resource_from_claims
    # def resource_from_claims(_claims) do
    #     {:error, :reason_for_error}
    # end
end