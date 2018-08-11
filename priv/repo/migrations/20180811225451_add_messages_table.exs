defmodule Guack.Repo.Migrations.AddMessagesTable do
  use Ecto.Migration

  def change do
    create table("messages") do
      add(:body, :text, null: false)
      add(:message_title, :string, default: "")
      add(:message_comment, :string, default: "")
      add(:user_id, references("users"))
      add(:chatroom_id, references("chatrooms"))

      timestamps()
    end

    create index("messages", [:user_id])
    create index("messages", [:chatroom_id])
  end
end
