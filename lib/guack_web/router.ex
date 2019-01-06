defmodule GuackWeb.Router do
  use GuackWeb, :router

  pipeline :graphql do
    plug Guack.Context
  end

  scope "/api" do
    pipe_through(:graphql)
    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: Guack.Web.Schema, interface: :advanced)
    forward("/", Absinthe.Plug, schema: Guack.Web.Schema)
  end

  # pipeline :api do
  #   plug :accepts, ["json", Absinthe.Plug.Parser]
  # end

  # pipeline :authentication do
  #   plug(Guack.Authentication.AccessPipeline)
  # end

  # scope "/", GuackWeb do
  #   pipe_through [:api]
  # end


end
