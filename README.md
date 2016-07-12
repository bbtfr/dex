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
def deps do
  [{:dex, "~> x.x.x"}]
end
```

