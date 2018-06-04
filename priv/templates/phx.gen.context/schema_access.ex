  alias <%= inspect schema.module %>

  def list_<%= schema.singular %>_order_by(order_by), do: <%= inspect schema.alias %> |> order_by(^order_by) |> <%= inspect schema.alias %>.list
