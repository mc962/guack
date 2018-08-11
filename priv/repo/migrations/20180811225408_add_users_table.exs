defmodule Guack.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add(:username, :string, null: false)
      add(:email, :string, null: false)
      add(:password_hash, :string, null: false)
      add(:first_name, :string)
      add(:last_name, :string)

      timestamps()
    end

    create unique_index("users", [:username])
  end
end
