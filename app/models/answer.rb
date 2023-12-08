class Answer < ApplicationRecord
  belongs_to :admin_user
  belongs_to :question
  belongs_to :paper

  after_create :deduct_the_token_from_the_user


  def deduct_the_token_from_the_user
    user_plan = self.admin_user.user_plan
    user_plan.update(balanced_token: user_plan.balanced_token - self.charged_token)
  end
end
