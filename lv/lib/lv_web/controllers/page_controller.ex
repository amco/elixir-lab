defmodule LvWeb.PageController do
  use LvWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:username, get_session(conn, :username))
    |> assign(:channel, get_session(conn, :channel))
    |> render("index.html")
  end
end
