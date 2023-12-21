ActiveAdmin.register Question do
  permit_params :question, :admin_user_id, :paper_id, :comma_separated_keywords
  filter :paper

  menu priority: 1, parent: 'Mains Answer Writing'

  index do
    selectable_column if current_admin_user.role == "admin"
    column :question
    column "Paper" do |question|
      question.paper.name
    end
    column :admin_user if current_admin_user.role == "admin"

    column "Answer" do |question|
      link_to "View", admin_question_path(question.id)
    end
  end

  form do |f|
    f.inputs class: 'isolated_bs' do
      f.input :question, class: 'form-control', input_html: { style: 'height: 50%;' }
      f.input :paper, class: 'form-control'
      f.input :comma_separated_keywords, class: 'form-control'
      f.input :admin_user_auth_token, as: :hidden, input_html: { value: current_admin_user.auth_token }
    end

    f.actions
  end




  show do
    render "show", locals: { question: question}
  end

end
