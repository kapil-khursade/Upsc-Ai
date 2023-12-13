ActiveAdmin.register Question do
  permit_params :question, :admin_user_id, :paper_id, :comma_separated_keywords
  filter :paper

  menu priority: 1, parent: 'Mains Answer Writing'

  index do
    selectable_column
    column :question
    column "Paper" do |question|
      question.paper.name
    end
    column "Key Words" do |question|
      question.keyword.pluck(:keyword).uniq.join(" ")
    end
    column :admin_user
    actions
  end

  form do |f|
    f.inputs do
      f.input :question
      f.input :paper
      f.input :comma_separated_keywords
      f.input :admin_user_auth_token, as: :hidden, input_html: { value: current_admin_user.auth_token }
    end
    f.actions
  end

  show do
    render "show", locals: { question: question}
  end

end
