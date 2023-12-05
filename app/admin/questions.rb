ActiveAdmin.register Question do
  permit_params :question, :admin_user_id, :paper_id, :comma_separated_keywords
  filter :paper

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
end
