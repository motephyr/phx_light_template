defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>Controller do
  use <%= inspect context.web_module %>, :controller

  alias <%= inspect context.module %>
  alias <%= inspect schema.module %>
  plug :put_layout, {<%= inspect context.web_module %>.LayoutView, "admin_sidebar.html"}


  def index(conn, _params) do
    # <%= schema.plural %> = <%= inspect schema.alias %>.list()
    <%= schema.plural %> = <%= inspect context.alias %>.list_<%= schema.singular %>_order_by(desc: :id)
    render(conn, "index.html", <%= schema.plural %>: <%= schema.plural %>)
  end

  def new(conn, _params) do
    changeset = <%= inspect schema.alias %>.change(%<%= inspect schema.alias %>{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{<%= inspect schema.singular %> => <%= schema.singular %>_params}) do
    case <%= inspect schema.alias %>.create(<%= schema.singular %>_params) do
      {:ok, <%= schema.singular %>} ->
        conn
        |> put_flash(:info, "<%= schema.human_singular %> created successfully.")
        |> redirect(to: <%= schema.route_helper %>_path(conn, :show, <%= schema.singular %>))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    <%= schema.singular %> = <%= inspect schema.alias %>.get!(id)
    render(conn, "show.html", <%= schema.singular %>: <%= schema.singular %>)
  end

  def edit(conn, %{"id" => id}) do
    <%= schema.singular %> = <%= inspect schema.alias %>.get!(id)
    changeset = <%= inspect schema.alias %>.change(<%= schema.singular %>)
    render(conn, "edit.html", <%= schema.singular %>: <%= schema.singular %>, changeset: changeset)
  end

  def update(conn, %{"id" => id, <%= inspect schema.singular %> => <%= schema.singular %>_params}) do
    <%= schema.singular %> = <%= inspect schema.alias %>.get!(id)

    case <%= inspect schema.alias %>.update(<%= schema.singular %>, <%= schema.singular %>_params) do
      {:ok, <%= schema.singular %>} ->
        conn
        |> put_flash(:info, "<%= schema.human_singular %> updated successfully.")
        |> redirect(to: <%= schema.route_helper %>_path(conn, :show, <%= schema.singular %>))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", <%= schema.singular %>: <%= schema.singular %>, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    <%= schema.singular %> = <%= inspect schema.alias %>.get!(id)
    {:ok, _<%= schema.singular %>} = <%= inspect schema.alias %>.delete(<%= schema.singular %>)

    conn
    |> put_flash(:info, "<%= schema.human_singular %> deleted successfully.")
    |> redirect(to: <%= schema.route_helper %>_path(conn, :index))
  end
end
