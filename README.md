# Elixir Deploy Manager

A set of Mix tasks to deploy your Elixir Application

## Usage

You can deploy your Elixir Application with the `deploy` task:

```shell
mix deploy
```

This task deploys the complete release for you. It will upload your project with `rsync`, download Elixir and NodeJS dependencies, compile Elixir & JavaScript source files, then build a release with `exrm`.

For your convenience, there're also some more tasks you can work with:

1. `mix deploy.setup`, setup a deployment environment for the current mix application.
2. `mix deploy.service`, run `exrm` application script on remote (eg: `mix deploy.service start`).
3. `mix deploy.mix`, run a Mix task on remote (eg: `mix deploy.mix ecto.migrate`).
4. `mix deploy.clean`, Ccean the deployment environment for the current mix application.

## Installation

Like `exrm`, this project's goal is to make deployments with Elixir projects a breeze. It is composed of a mix task, and build your Elixir project with `exrm`, then deploy it to your server. All you have to do to get started is the following:

**Add `dex` to your list of dependencies in `mix.exs`:**

```elixir
def application do
  [applications: [:dex]]
end

def deps do
  [{:dex, "~> x.x.x"}]
end
```

There are a number of options you can tweak to customize the way `dex` is used. All of the options described below should be put into your config.exs file, or prod.secret.exs if you don't want it upload to your scm.

```elixir
config :dex, DeployManager,
  server: "your.server.com",
  username: "your_username",
  deploy_to: "/var/www/your_app",
  link_files: ["config/prod.secret.exs", ".env"]

```
