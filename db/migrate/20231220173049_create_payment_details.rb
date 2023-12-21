class CreatePaymentDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_details do |t|
      t.string :order_id
      t.string :payment_id
      t.string :signature
      t.date :date
      t.float :amount
      t.integer :tokens
      t.integer :status, default: 0
      t.references :admin_user, foreign_key: true
      t.timestamps
    end
  end
end
