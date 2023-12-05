class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :question, limit: 200
      t.references :admin_user, foreign_key: true
      t.references :paper, foreign_key: true
      t.timestamps
    end
  end
end
