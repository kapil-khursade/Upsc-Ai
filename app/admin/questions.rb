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
    actions
  end

  form do |f|
    f.inputs do
      f.input :question
      f.input :paper
      f.input :comma_separated_keywords
      f.input :admin_user_id, as: :hidden, input_html: { value: current_admin_user.id }
    end
    f.actions
  end

  controller do
    def create
      super do |success, failure|
        failure.html do
          # Check for validation errors and set the flash alert
          flash[:alert] = resource.errors.full_messages.join(', ') if resource.errors.any?
          redirect_to collection_path
        end
      end
    end
  end
end
