defmodule Dictionary.Mixfile do
  use Mix.Project

  def project do
    [app: :dictionary,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [
      mod: { Dictionary.Application, [] },
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end
end
