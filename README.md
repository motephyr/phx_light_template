# PhxLightTemplate
for after phx 1.3, move duplicate code from context to model.

## Installation

Add the latest stable release to your `mix.exs` file

```elixir
defp deps do
  [
    ...,
    {:phx_light_template, github: "motephyr/phx_light_template", only: [:dev, :test], runtime: false}

  ]
end
```

```
mix override.template
```

to get phx light template.

and you can use phx generate as usual.