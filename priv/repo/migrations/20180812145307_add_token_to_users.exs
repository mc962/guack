defmodule Guack.Repo.Migrations.AddTokenToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      # TODO move this token to a faster datastore such as Redis
      add :token, :text
    end
  end
end
