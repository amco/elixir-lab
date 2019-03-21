defmodule LvWeb.SessionsController do
  use LvWeb, :controller

  def create(conn, params) do
    conn
    |> put_session(:username, params["username"])
    |> put_session(:channel, params["channel"])
    |> redirect(to: "/")
  end
end
