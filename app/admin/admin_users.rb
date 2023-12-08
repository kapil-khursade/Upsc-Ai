ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :role
  menu label: "Aspirents"

  index do
    selectable_column
    id_column
    column :email
    column "Balanced Token" do |user|
       user.user_plan.balanced_token
    end
    column "Charged Token" do |user|
      user.answer.sum(:charged_token)
    end
    column "Usage Token" do |user|
      user.answer.sum(:usage_token)
    end
    actions
  end

  filter :email

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
    end
    f.actions
  end
end
