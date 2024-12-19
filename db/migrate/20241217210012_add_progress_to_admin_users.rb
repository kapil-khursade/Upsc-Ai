class AddProgressToAdminUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :admin_users, :progress, :integer
  end
end
