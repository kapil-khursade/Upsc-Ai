ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: "Dashboard"

  content do
    render partial: "dashboard", locals: { current_user: current_admin_user }
  end
end
