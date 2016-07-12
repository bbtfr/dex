defmodule DeployManager.Utils do
  @moduledoc """
  This module provides helper functions for the `mix deploy` and
  `mix deploy.setup` tasks.
  """

  alias  ReleaseManager.Utils.Logger

  def remote_server config do
    "#{config.username}#{if config.password, do: ":#{config.password}"}@#{config.server}"
  end

  def remote_command config, command do
    ~s(ssh #{remote_server config} -- "cd #{config.deploy_to} && #{command}")
  end

  def execute config, command, true do
    case Mix.Shell.IO.cmd command do
      0 -> config
      result ->
        Logger.error "Failed to execute '#{command}'"
        System.halt(result)
    end
  end

  def execute config, command, false do
    Mix.Shell.IO.cmd command
    config
  end

  def execute_locally config, command, exit_on_error \\ true do
    Logger.debug "execute locally: '#{command}'"
    execute config, command, exit_on_error
  end

  def execute_remotely config, command, exit_on_error \\ true do
    Logger.debug "execute remotelly: '#{command}'"
    execute config, remote_command(config, command), exit_on_error
  end

  def log_info config, message do
    Logger.info message
    config
  end

  def parse_args _args do
    name = Mix.Project.config |> Keyword.get(:app)

    defaults = %{
      name:    name |> Atom.to_string,
      version: Mix.Project.config |> Keyword.get(:version),
      env:     Mix.env
    }

    [:username, :password, :server, :deploy_to, :link_files]
    |> Enum.map(&({&1, Application.get_env(name, DeployManager) |> Keyword.get(&1)}))
    |> Enum.into(defaults)
  end
end
