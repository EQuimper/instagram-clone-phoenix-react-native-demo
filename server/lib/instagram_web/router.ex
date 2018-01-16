defmodule InstagramWeb.Router do
  use InstagramWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InstagramWeb do
    pipe_through :api
  end
end
