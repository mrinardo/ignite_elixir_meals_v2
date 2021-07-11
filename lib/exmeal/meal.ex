defmodule Exmeal.Meal do
  use Ecto.Schema

  import Ecto.Changeset

  alias Exmeal.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:description, :date, :calories, :user_id]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "meals" do
    field :description, :string
    field :date, :utc_datetime_usec
    field :calories, :integer

    belongs_to :user, User

    timestamps()
  end

  def changeset(params) do
    {:ok, now} = DateTime.now("Etc/UTC")

    %__MODULE__{}
    |> change(date: now)
    |> create_changeset(params)
  end

  def changeset(struct, params) do
    struct
    |> create_changeset(params)
  end

  defp create_changeset(struct, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_number(:calories, greater_than: 0)
    |> validate_change(:date, &cannot_be_future_date/2)
  end

  defp cannot_be_future_date(:date, data) do
    {:ok, now} = DateTime.now("Etc/UTC")

    case Date.compare(DateTime.to_date(data), DateTime.to_date(now)) do
      :gt -> [date: "Date cannot be in the future."]
      _ -> []
    end
  end
end
