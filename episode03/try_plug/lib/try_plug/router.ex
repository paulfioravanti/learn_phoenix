# iex> Plug.Adapters.Cowboy.http TryPlug.Router, []
defmodule TryPlug.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/hello" do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello World!")
  end

  match _ do
    conn
    |> send_resp(404, "Not Found")
  end
end
