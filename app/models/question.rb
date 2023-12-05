class Question < ApplicationRecord
   belongs_to :admin_user
   belongs_to :paper
   has_many :keyword

   after_create :create_keywords

   def create_keywords
      self.comma_separated_keywords.split(",").each do |key|
        Keyword.create(keyword: key, admin_user: self.admin_user, question: self, paper: self.paper)
      end
      generate_the_answer
   end

   def generate_the_answer
      GetAnswerJob.perform_async(self.id)
   end
end
