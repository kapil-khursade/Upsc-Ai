class CreateAnswerErrors < ActiveRecord::Migration[7.1]
  def change
    create_table :answer_errors do |t|
      t.references :question, foreign_key: true
      t.integer :status
      t.string :message
      t.integer :try_number
      t.string :querry_string
      t.datetime :error_date_time
      t.timestamps
    end
  end
end
