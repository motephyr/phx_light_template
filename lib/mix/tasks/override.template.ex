defmodule Mix.Tasks.Override.Template do
  @moduledoc """
  Generates a Phoenix resource.
      mix phoenix.gen.json User users name:string age:integer
  The first argument is the module name followed by
  its plural name (used for resources and schema).
  The generated resource will contain:
    * a schema in web/models
    * a view in web/views
    * a controller in web/controllers
    * a migration file for the repository
    * test files for generated model and controller
  If you already have a model, the generated model can be skipped
  with `--no-model`. Read the documentation for `phoenix.gen.model`
  for more information on attributes and namespaced resources.
  """
  use Mix.Task


  def run([]) do
    generate_file()
  end

  defp generate_file() do
    source_destination = Path.join(:code.lib_dir(:phx_light_template), "/priv/templates")
    to_destination = Path.join(System.cwd(), "/priv/templates")

    File.cp_r(source_destination, to_destination)
  end

end