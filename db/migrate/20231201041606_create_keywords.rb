class CreateKeywords < ActiveRecord::Migration[7.1]
  def change
    create_table :keywords do |t|
      t.string :keyword
      t.references :admin_user, foreign_key: true
      t.references :question, foreign_key: true
      t.references :paper, foreign_key: true
      t.timestamps
    end
  end
end
