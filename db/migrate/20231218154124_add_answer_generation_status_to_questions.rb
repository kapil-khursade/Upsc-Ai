class AddAnswerGenerationStatusToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :answer_generation_status, :integer
  end
end
