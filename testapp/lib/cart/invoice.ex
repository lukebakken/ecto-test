defmodule Cart.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cart.{Invoice, InvoiceItem}

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "invoices" do
    field(:customer, :string)
    field(:amount, :decimal, precision: 12, scale: 2)
    field(:balance, :decimal, precision: 12, scale: 2)
    field(:date, :date)
    has_many(:invoice_items, InvoiceItem, on_delete: :delete_all)

    timestamps()
  end

  @fields ~w(customer amount balance date)a

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, @fields)
    |> validate_required([:customer, :date])
  end

  def create(params) do
    cs =
      changeset(%Invoice{}, params)
      |> validate_item_count(params)
      |> put_assoc(:invoice_items, get_items(params))

    if cs.valid? do
      TestApp.Repo.insert(cs)
    else
      cs
    end
  end

  defp get_items(params) do
    items = params[:invoice_items] || params["invoice_items"]
    Enum.map(items, fn item -> InvoiceItem.changeset(%InvoiceItem{}, item) end)
  end

  defp validate_item_count(cs, params) do
    items = params[:invoice_items] || params["invoice_items"]

    if Enum.count(items) <= 0 do
      add_error(cs, :invoice_items, "Invalid number of items")
    else
      cs
    end
  end
end
