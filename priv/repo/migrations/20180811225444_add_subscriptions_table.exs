defmodule Guack.Repo.Migrations.AddSubscriptionsTable do
  use Ecto.Migration

  def change do
    create table("subscriptions") do
      add(:user_id, references("users"))
      add(:chatroom_id, references("chatrooms"))

      timestamps()
    end

    create index("subscriptions", [:user_id])
    create index("subscriptions", [:chatroom_id])
  end
end
