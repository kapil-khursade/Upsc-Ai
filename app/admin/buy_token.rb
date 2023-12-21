ActiveAdmin.register_page "BuyToken" do
  menu priority: 1, parent: 'Billing & Payments'

  content do
    render partial: "buy_token", locals: { current_user: current_admin_user }
  end
end
