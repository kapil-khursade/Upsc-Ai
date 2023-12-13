class AnswerError < ApplicationRecord
  belongs_to :question
  enum status: ["Will_Retry_Soon", "Failed", "Solved"]
end
