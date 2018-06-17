defmodule <%= inspect schema.module %> do
  use Ecto.Schema
  import Ecto.Changeset
  alias <%= inspect schema.module %>
  alias <%= inspect schema.repo %>
  import Ecto.Query, warn: false


<%= if schema.binary_id do %>
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id<% end %>
  schema <%= inspect schema.table %> do
<%= for {k, v} <- schema.types do %>    field <%= inspect k %>, <%= inspect v %><%= schema.defaults[k] %>
<% end %><%= for {_, k, _, _} <- schema.assocs do %>    field <%= inspect k %>, <%= if schema.binary_id do %>:binary_id<% else %>:id<% end %>
<% end %>
    timestamps()
  end

  @doc false
  def changeset(%<%= inspect schema.alias %>{} = <%= schema.singular %>, attrs, :basic) do
    <%= schema.singular %>
    |> cast(attrs, [<%= Enum.map_join(schema.attrs, ", ", &inspect(elem(&1, 0))) %>])
    |> validate_required([<%= Enum.map_join(schema.attrs, ", ", &inspect(elem(&1, 0))) %>])
<%= for k <- schema.uniques do %>    |> unique_constraint(<%= inspect k %>)
<% end %>  end

def list(<%= schema.singular %> \\ __MODULE__, query \\ []) do
  <%= schema.singular %>
  |> Ecto.Query.where(^query)
  |> Repo.all()
end

  def get!(id), do: Repo.get!(__MODULE__, id)

  def create(attrs \\ %{}, change_state \\ :basic) do
    %__MODULE__{}
    |> __MODULE__.changeset(attrs, change_state)
    |> Repo.insert()
  end

  def update(%__MODULE__{} = <%= schema.singular %>, attrs, change_state \\ :basic) do
    <%= schema.singular %>
    |> __MODULE__.changeset(attrs, change_state)
    |> Repo.update()
  end

  def delete(%__MODULE__{} = <%= schema.singular %>) do
    Repo.delete(<%= schema.singular %>)
  end

  def change(%__MODULE__{} = <%= schema.singular %>, change_state \\ :basic) do
    __MODULE__.changeset(<%= schema.singular %>, %{}, change_state)
  end
end
