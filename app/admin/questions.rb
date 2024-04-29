ActiveAdmin.register Question do
  permit_params :question, :admin_user_id, :paper_id, :comma_separated_keywords
  filter :paper

  menu priority: 1, parent: 'Mains Answer Writing'

  index do
    selectable_column if current_admin_user.role == "admin"
    column :question
    column "Paper" do |question|
      html = <<-HTML
      <div class="isolated_bs">
        <div class="col-md-4 text-center">
          <span class="badge rounded-pill bg-primary">#{question.paper.name}</span>
        </div>
      </div>
      HTML
      html.html_safe
    end
    column "Created At" do |question|
      question.created_at.strftime("%d %b %y")
    end
    column :admin_user if current_admin_user.role == "admin"

    column "Answer" do |question|
      html = <<-HTML
      <div class="isolated_bs">
        <a class="btn btn-outline-secondary btn-sm" href="#{admin_question_path(question.id)}" role="button">view</a>
      </div>
      HTML
      html.html_safe
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
