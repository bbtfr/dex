defmodule Mix.Tasks.Deploy.Setup do
  @moduledoc """
  Setup a deployment environment for the current mix application.
  ## Examples
      # Setup a deployment environment using defaults
      mix deploy.setup
  """

  @shortdoc "Setup a deployment environment for the current mix application"

  use    Mix.Task
  import DeployManager.Utils

  def run args do
    parse_args(args)
    |> execute_remotely("mix local.hex --force")
    |> execute_remotely("mix local.rebar --force")
  end
end
