defmodule Dex.Mixfile do
  use Mix.Project

  def project do
    [app: :dex,
     version: "0.1.2",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:exrm, "~> 1.0", optional: true},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp description do
    """
    Deploy Elixir application with Mix.Task.
    """
  end

  defp package do
    [# These are the default files included in the package
     name: :dex,
     files: ["lib", "config", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Theo Li"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/bbtfr/dex",
              "Docs" => "http://bbtfr.github.io/dex/"}]
  end
end
