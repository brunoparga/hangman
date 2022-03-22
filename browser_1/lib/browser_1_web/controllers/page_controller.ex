defmodule Browser1Web.PageController do
  use Browser1Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
