defmodule Mix.Tasks.Deploy.Clean do
  @moduledoc """
  Clean the deployment environment for the current mix application.
  ## Examples
      # Clean the deployment environment
      mix deploy.clean
  """

  @shortdoc "Clean the deployment environment for the current mix application"

  use    Mix.Task
  import DeployManager.Utils

  def run args do
    parse_args(args)
    |> execute_remotely("rm -rf *")
  end
end
