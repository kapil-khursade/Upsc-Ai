class CreateUserPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :user_plans do |t|
      t.references :admin_user, foreign_key: true
      t.integer :balanced_token
      t.timestamps
    end
  end
end
