defmodule TestApp.CLI do
  require Logger
  alias Cart.{Item, Invoice, InvoiceItem}
  def main(args \\ []) do
    Logger.info("args: #{inspect(args)}")
    TestApp.Repo.insert(%Item{name: "Chocolates", price: Decimal.new("5")})
    TestApp.Repo.insert(%Item{name: "Gum", price: Decimal.new("2.5")})
    TestApp.Repo.insert(%Item{name: "Milk", price: Decimal.new("1.5")})
    TestApp.Repo.insert(%Item{name: "Rice", price: Decimal.new("2")})
    TestApp.Repo.insert(%Item{name: "Chocolates", price: Decimal.new("10")})
  end
end
