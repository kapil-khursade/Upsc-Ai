class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.references :admin_user, foreign_key: true
      t.references :question, foreign_key: true
      t.references :paper, foreign_key: true
      t.string :answer
      t.integer :usage_token
      t.integer :charged_token
      t.timestamps
    end
  end
end
