defmodule GuackWeb.Router do
  use GuackWeb, :router

  pipeline :graphql do
    plug Guack.Context
  end

  scope "/api" do
    pipe_through :graphql

    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: Guack.Web.Schema, interface: :advanced)
    forward("/", Absinthe.Plug, schema: Guack.Web.Schema)    
  end
end
