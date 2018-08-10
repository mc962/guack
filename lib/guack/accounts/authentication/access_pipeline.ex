defmodule Guack.Authentication.AccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :guack

  plug(Guardian.Plug.VerifySession, claims: %{"type" => "access"})
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
