defmodule Mix.Tasks.Deploy do
  @moduledoc """
  Deploy a release for the current mix application.
  ## Examples
      # Deploy a release using defaults
      mix deploy
  """

  @shortdoc "Deploy a release for the current mix application"

  use    Mix.Task
  import DeployManager.Utils

  def run args do
    parse_args(args)
    |> clean_local_source_tree
    |> upload_sources
    |> build_on_remote
  end

  def clean_local_source_tree config do
    config
    |> log_info("Cleaning local source tree")
    |> execute_locally("mix clean")
  end

  def upload_sources config do
    config
    |> log_info("Uploading sources")
    |> execute_locally(~s(rsync -avz --rsh=ssh #{if Map.has_key?(config, :link_files), do: config.link_files |> Enum.map(&("--include='#{&1}'")) |> Enum.join(" ")} --exclude='.git' --filter=':- .gitignore' ./ #{remote_server config}:#{config.deploy_to}))
  end

  def build_on_remote config do
    config
    |> log_info("Getting Elixir dependencies on remote")
    |> execute_remotely("mix deps.get --only prod")
    |> log_info("Compiling application on remote")
    |> execute_remotely("MIX_ENV=prod mix compile")
    |> log_info("Getting NodeJS dependencies on remote")
    |> execute_remotely("npm install")
    |> log_info("Compiling assets on remote")
    |> execute_remotely("node node_modules/brunch/bin/brunch build")
    |> execute_remotely("MIX_ENV=prod mix phoenix.digest")
    |> log_info("Building release on remote")
    |> execute_remotely("MIX_ENV=prod mix release")
  end
end
