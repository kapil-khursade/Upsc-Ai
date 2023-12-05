class AddCommaSeparatedKeywordsToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :comma_separated_keywords, :string
  end
end
