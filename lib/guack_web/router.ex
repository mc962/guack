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
end
