class Answer < ApplicationRecord
  belongs_to :admin_user
  belongs_to :question
  belongs_to :paper
end
