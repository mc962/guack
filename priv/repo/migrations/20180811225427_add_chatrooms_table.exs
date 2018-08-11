defmodule Guack.Repo.Migrations.AddChatroomsTable do
  use Ecto.Migration

  def change do
    create table("chatrooms") do
      add(:room_title, :string, null: false)
      add(:room_type, :string, null: false)
      add(:purpose, :text)

      timestamps()
    end

    create index("chatrooms", [:room_title])
    create index("chatrooms", [:room_type])
  end
end
