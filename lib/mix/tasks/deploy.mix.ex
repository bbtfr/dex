defmodule Mix.Tasks.Deploy.Mix do
  @moduledoc """
  Run mix task for the current mix application on remote.
  ## Examples
      # Run the repository migrations
      mix deploy.mix ecto.migrate
      # Digest and compress static files
      mix deploy.mix phoenix.digest
      # Start applications and their servers
      mix deploy.mix phoenix.server
  """

  @shortdoc "Setup a deployment environment for the current mix application"

  use    Mix.Task
  import DeployManager.Utils

  def run args do
    config = parse_args(args)
    execute_remotely(config, "MIX_ENV=prod mix #{Enum.join args, " "}", false)
  end
end
