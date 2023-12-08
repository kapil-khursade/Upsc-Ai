ActiveAdmin.register Answer do

  permit_params :question, :admin_user_id, :paper_id, :comma_separated_keywords
  filter :paper

  menu priority: 2, parent: 'Mains Answer Writing'

  index do
    selectable_column
    column "Paper" do |answer|
      answer.question.paper.name
    end
    column "Qestion" do |answer|
      answer.question.question
    end
    actions
  end
end
