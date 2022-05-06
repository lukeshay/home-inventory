defmodule HomeInventory.Inventory.Item do
  alias HomeInventory.Inventory.Item
  alias HomeInventory.Repo
  import Ecto.Changeset
  import Ecto.Query, warn: false
  use Ecto.Schema

  schema "items" do
    field(:name, :string)
    field(:quantity, :integer)
    field(:sku, :string)
    belongs_to(:location, HomeInventory.Inventory.Location)

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :location_id, :quantity, :sku])
    |> validate_required([:name, :location_id])
  end

  @doc """
  Returns the list of items.

  ## Examples

      iex> list()
      [%Item{}, ...]

  """
  def list do
    Repo.all(Item)
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get!(123)
      %Item{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Item, id)

  @doc """
  Creates a item.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Item{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item.

  ## Examples

      iex> delete(item)
      {:ok, %Item{}}

      iex> delete(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%Item{} = item) do
    Repo.delete(item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change(item)
      %Ecto.Changeset{data: %Item{}}

  """
  def change(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end
end
