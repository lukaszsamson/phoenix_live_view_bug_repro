defmodule Demo.Level do
  use Ecto.Schema
  import Ecto.Changeset

  schema "levels" do
    field :level, :integer
    field :step, :decimal
    field :volume, :decimal
    field :genere, :string

    timestamps()
  end

  @required ~w(
    level
    step
    volume
    genere
  )a

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> validate_number(:level, greater_than: 0)
    |> validate_number(:step, greater_than: 0)
    |> validate_number(:volume, greater_than_or_equal_to: 0)
  end
end
