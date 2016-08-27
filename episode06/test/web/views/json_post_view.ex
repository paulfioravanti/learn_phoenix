defmodule Test.JSONPostView do
  use Test.Web, :view

  def render("index.json", %{json_posts: json_posts}) do
    %{data: render_many(json_posts, Test.JSONPostView, "json_post.json")}
  end

  def render("show.json", %{json_post: json_post}) do
    %{data: render_one(json_post, Test.JSONPostView, "json_post.json")}
  end

  def render("json_post.json", %{json_post: json_post}) do
    %{id: json_post.id}
  end
end
