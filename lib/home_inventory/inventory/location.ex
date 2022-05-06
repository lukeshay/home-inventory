defmodule HomeInventory.Inventory.Location do
  alias HomeInventory.Inventory.Location
  alias HomeInventory.Repo
  import Ecto.Changeset
  import Ecto.Query, warn: false
  use Ecto.Schema

  schema "locations" do
    field(:description, :string)
    field(:name, :string)
    has_many(:items, HomeInventory.Inventory.Item)

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end

  @doc """
  Returns the list of locations.

  ## Examples

      iex> list()
      [%Location{}, ...]

  """
  def list do
    Repo.all(Location)
  end

  @doc """
  Gets a single location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get!(123)
      %Location{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Location, id)

  def get_with_items!(id), do: Repo.get!(Location, id) |> Repo.preload(:items)

  @doc """
  Creates a location.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Location{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a location.

  ## Examples

      iex> update(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a location.

  ## Examples

      iex> delete(location)
      {:ok, %Location{}}

      iex> delete(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change(location)
      %Ecto.Changeset{data: %Location{}}

  """
  def change(%Location{} = location, attrs \\ %{}) do
    Location.changeset(location, attrs)
  end
end
