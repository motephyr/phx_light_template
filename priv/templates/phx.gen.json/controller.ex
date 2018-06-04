defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>Controller do
  use <%= inspect context.web_module %>, :controller

  alias <%= inspect context.module %>
  alias <%= inspect schema.module %>

  action_fallback <%= inspect context.web_module %>.FallbackController

  def index(conn, _params) do
    <%= schema.plural %> = <%= inspect context.alias %>.list_<%= schema.singular %>_order_by(desc: :id)
    render(conn, "index.json", <%= schema.plural %>: <%= schema.plural %>)
  end

  def create(conn, %{<%= inspect schema.singular %> => <%= schema.singular %>_params}) do
    with {:ok, %<%= inspect schema.alias %>{} = <%= schema.singular %>} <- <%= inspect schema.alias %>.create(<%= schema.singular %>_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", <%= schema.route_helper %>_path(conn, :show, <%= schema.singular %>))
      |> render("show.json", <%= schema.singular %>: <%= schema.singular %>)
    end
  end

  def show(conn, %{"id" => id}) do
    <%= schema.singular %> = <%= inspect schema.alias %>.get!(id)
    render(conn, "show.json", <%= schema.singular %>: <%= schema.singular %>)
  end

  def update(conn, %{"id" => id, <%= inspect schema.singular %> => <%= schema.singular %>_params}) do
    <%= schema.singular %> = <%= inspect schema.alias %>.get!(id)

    with {:ok, %<%= inspect schema.alias %>{} = <%= schema.singular %>} <- <%= inspect schema.alias %>.update(<%= schema.singular %>, <%= schema.singular %>_params) do
      render(conn, "show.json", <%= schema.singular %>: <%= schema.singular %>)
    end
  end

  def delete(conn, %{"id" => id}) do
    <%= schema.singular %> = <%= inspect schema.alias %>.get!(id)
    with {:ok, %<%= inspect schema.alias %>{}} <- <%= inspect schema.alias %>.delete(<%= schema.singular %>) do
      send_resp(conn, :no_content, "")
    end
  end
end
