defmodule TennisPhxWeb.PageController do
  use TennisPhxWeb, :controller

  def index(conn, _params) do
    conn
    # |> put_flash(:success, "Player added successfully!")
    # |> put_flash(:info, "You can check all players at player#index")
    # |> put_flash(:error, "Let's pretend we have an error.")
    |> render("index.html")
  end
end
