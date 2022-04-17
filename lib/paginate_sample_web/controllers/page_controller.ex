defmodule PaginateSampleWeb.PageController do
  use PaginateSampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
