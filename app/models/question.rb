class Question < ApplicationRecord
   belongs_to :admin_user
   belongs_to :paper
   has_many :keyword
   has_many :answer
   has_many :answer_error

   enum answer_generation_status: ["Generated", "Your Answer Generation Is In Progress", "Error"]

   after_create :create_keywords
   validate :check_token_balance, on: :create

   def check_token_balance
      if self.admin_user.user_plan.balanced_token <= 0
        errors.add(:base, "Not enough tokens to generate the answer")
      end
   end

   def create_keywords
      self.comma_separated_keywords.split(",").each do |key|
        Keyword.create(keyword: key, admin_user: self.admin_user, question: self, paper: self.paper)
      end
     generate_the_answer
   end

   def generate_the_answer
      if self.admin_user.user_plan.balanced_token > 0
         GetAnswerJob.perform_async(self.id)
      end
   end
end
