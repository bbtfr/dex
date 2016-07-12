defmodule Mix.Tasks.Deploy.Service do
  @moduledoc """
  Run service script for the current mix application on remote.
  ## Examples
      # Start current mix application
      mix deploy.service start
      # Stop current mix application
      mix deploy.service stop
  """

  @shortdoc "Setup a deployment environment for the current mix application"

  use    Mix.Task
  import DeployManager.Utils

  def run args do
    config = parse_args(args)
    execute_remotely(config, "rel/#{config.name}/bin/#{config.name} #{Enum.join args, " "}", false)
  end
end
