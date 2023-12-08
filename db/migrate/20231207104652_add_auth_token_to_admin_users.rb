class AddAuthTokenToAdminUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :admin_users, :auth_token, :string
  end
end
