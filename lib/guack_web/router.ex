defmodule GuackWeb.Router do
  use GuackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authentication do
    plug(Guack.Authentication.AccessPipeline)
  end

  scope "/api", GuackWeb do
    pipe_through :api
  end

  forward("/graphql", Absinthe.Plug, schema: Guack.Web.Schema)
  forward("/graphiql", Absinthe.Plug.GraphiQL, schema: Guack.Web.Schema)
end
