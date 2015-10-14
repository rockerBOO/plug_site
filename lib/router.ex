defmodule MyRouter do
  use Plug.Router
  import Plug.Conn

  plug :match
  plug :dispatch

  get "/" do
    html = "<html>" <>
      "<head><title><%= @title %></title></head>" <>
      "<body><%= @body %></body>" <>
    "</html>"
    body = EEx.eval_string(html,
        assigns: [title: "Hello", body: "World"])
    send_resp(conn, 200, body)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  def start_link(opts \\ []) do
    Plug.Adapters.Cowboy.http __MODULE__, opts
  end
end