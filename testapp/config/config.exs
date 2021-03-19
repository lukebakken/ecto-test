use Mix.Config

config :testapp, ecto_repos: [TestApp.Repo]

config :testapp, TestApp.Repo,
  database: "testapp_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :logger,
       :console,
       level: :debug,
       handle_otp_reports: true,
       handle_sasl_reports: true
