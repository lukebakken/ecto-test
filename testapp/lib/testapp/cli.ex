defmodule TestApp.CLI do
  require Logger
  alias Cart.Item
  alias TestApp.Repo

  def main(args \\ []) do
    Logger.debug("args: #{inspect(args)}")

    started_applications = Application.started_applications()
    Logger.debug("started apps: #{inspect(started_applications)}")

    tx_task =
      Task.async(fn ->
        Repo.transaction(fn ->
          Repo.insert(%Item{name: "Chocolates", price: Decimal.new("5")})
          Repo.insert(%Item{name: "Gum", price: Decimal.new("2.5")})
          Repo.insert(%Item{name: "Milk", price: Decimal.new("1.5")})
          exit(:boom)
          Repo.insert(%Item{name: "Rice", price: Decimal.new("2")})
          Repo.insert(%Item{name: "Chocolates", price: Decimal.new("10")})
          :ok
        end)
      end)

    tx_task_result = Task.await(tx_task)
    Logger.debug("tx_task_result: #{inspect(tx_task_result)}")
  end
end
