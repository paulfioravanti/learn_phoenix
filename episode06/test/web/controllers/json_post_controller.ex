defmodule Test.JSONPostController do
  use Test.Web, :controller

  alias Test.JSONPost

  plug :scrub_params, "json_post" when action in [:create, :update]

  def index(conn, _params) do
    json_posts = Repo.all(JSONPost)
    render(conn, "index.json", json_posts: json_posts)
  end

  def create(conn, %{"json_post" => json_post_params}) do
    changeset = JSONPost.changeset(%JSONPost{}, json_post_params)

    case Repo.insert(changeset) do
      {:ok, json_post} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", json_post_path(conn, :show, json_post))
        |> render("show.json", json_post: json_post)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Test.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    json_post = Repo.get!(JSONPost, id)
    render(conn, "show.json", json_post: json_post)
  end

  def update(conn, %{"id" => id, "json_post" => json_post_params}) do
    json_post = Repo.get!(JSONPost, id)
    changeset = JSONPost.changeset(json_post, json_post_params)

    case Repo.update(changeset) do
      {:ok, json_post} ->
        render(conn, "show.json", json_post: json_post)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Test.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    json_post = Repo.get!(JSONPost, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(json_post)

    send_resp(conn, :no_content, "")
  end
end
