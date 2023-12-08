ActiveAdmin.register Keyword do
  permit_params :keyword, :admin_user_id, :question_id, :paper_id

  menu priority: 2, parent: 'Variables'

  index do
    selectable_column
    column :keyword
    column :question
    column :admin_user
    actions
  end

  filter :admin_user_email, as: :string, label: 'User Email'
  filter :question_question, as: :string, label: 'Question'
end
