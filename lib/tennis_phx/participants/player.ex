defmodule TennisPhx.Participants.Player do
  use Ecto.Schema
  use Waffle.Ecto.Schema
  import Ecto.Changeset

  alias TennisPhx.Events.Tour
  alias TennisPhx.Tags.Tag

  schema "players" do
    field :birthdate, :naive_datetime
    field :info, :string
    field :name, :string
    field :nickname, :string
    field :points, :integer, default: 0
    field :hand, :string
    field :avatar, TennisPhx.AvatarUploader.Type
    field :country, :string
    field :city, :string


    timestamps()

    many_to_many(
      :tours,
      Tour,
      join_through: "player_tour",
      on_replace: :delete
    )

    many_to_many(
     :tags,
     Tag,
     join_through: "player_tag",
     on_replace: :delete
   )
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :nickname, :info, :birthdate, :points, :hand, :country, :city])
    |> cast_attachments(attrs, [:avatar])
    |> validate_required([:name])
  end


end
