class AddMobileAppAuthTokenToAdminUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :admin_users, :mobile_app_auth_token, :string
  end
end
