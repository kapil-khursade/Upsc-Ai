module UserConcern
  extend ActiveSupport::Concern

  class Dashboard
    include ActionView::Helpers::NumberHelper
    def get_user_data_card(user)
      answers = user.answer
      questions = user.question
      user_plan = user.user_plan

      user_warnings = []

      user_warnings << {text: "Your Don't Have Enough Tokens. Please Buy Tokens.", levle: "red"} if user_plan.balanced_token < 0
      user_warnings << {text: "You Are Low On Tokens.", levle: "orange"} if user_plan.balanced_token > 0 && user_plan.balanced_token < 500
      return {
        user_data: [
          {
            lable: 'Token Balanced',
            data: number_with_delimiter(user_plan.balanced_token)
          },
          {
            lable: 'Consumed Token',
            data: number_with_delimiter(answers.sum(:charged_token))
          },
          {
            lable: 'Questions',
            data: number_with_delimiter(questions.try(:count)) || 0
          },
          {
            lable: 'Answers',
            data: number_with_delimiter(answers.try(:count)) || 0
          }
        ],
        user_warnings: user_warnings
      }
    end
  end
end
