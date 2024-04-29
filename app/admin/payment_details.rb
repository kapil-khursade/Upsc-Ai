ActiveAdmin.register PaymentDetail do
  menu priority: 2, parent: 'Billing & Payments'
  filter :status
  index do
    selectable_column if current_admin_user.role == "admin"
    column :order_id
    column :date
    column "amount" do |record|
      number_to_currency(record.amount, unit: "₹")
    end
    column "tokens" do |record|
      number_with_delimiter(record.tokens)
    end
    column :status
    actions if current_admin_user.role == "admin"
  end
end
