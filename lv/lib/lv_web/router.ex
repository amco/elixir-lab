defmodule LvWeb.Router do
  use LvWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LvWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/live", LiveController, :index
    post "/sessions", SessionsController, :create
    get "/timer_live/", Lv.TimerView, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", LvWeb do
  #   pipe_through :api
  # end
end
