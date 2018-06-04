
  describe "<%= schema.plural %>" do
    alias <%= inspect schema.module %>

    @valid_attrs <%= inspect schema.params.create %>
    @update_attrs <%= inspect schema.params.update %>
    @invalid_attrs <%= inspect for {key, _} <- schema.params.create, into: %{}, do: {key, nil} %>

    def <%= schema.singular %>_fixture(attrs \\ %{}) do
      {:ok, <%= schema.singular %>} =
        attrs
        |> Enum.into(@valid_attrs)
        |> <%= inspect schema.alias %>.create()

      <%= schema.singular %>
    end

    test "list_<%= schema.singular %>_order_by/1 returns all <%= schema.plural %>" do
      <%= schema.singular %>5 = <%= schema.singular %>_fixture()
      <%= schema.singular %>8 = <%= schema.singular %>_fixture()
      <%= schema.singular %>10 = <%= schema.singular %>_fixture()

      assert <%= inspect context.alias %>.list_<%= schema.singular %>_order_by(desc: :id) == [<%= schema.singular %>10, <%= schema.singular %>8, <%= schema.singular %>5]
    end

  end
