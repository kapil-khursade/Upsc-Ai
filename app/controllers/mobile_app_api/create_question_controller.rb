class MobileAppApi::CreateQuestionController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    auth_token = params[:auth_token]
    @user = AdminUser.find_by_mobile_app_auth_token(auth_token)
    @paper_id = params[:paperId]
    @questionText = params[:questionText]
    @commaSeperatedKeywords = params[:commaSeperatedKeywords]

    if @user
      begin
        render json: { questionId: create_question }
      rescue StandardError => error
        render json: { error: error.to_s }
      end
    else
      render json: { error: 'User Not Found' }, status: :unauthorized
    end
  end

  def create_question
    question = Question.new(
      admin_user: @user,
      paper_id: @paper_id,
      comma_separated_keywords: @commaSeperatedKeywords,
      question: @questionText
    )
    question.save!
    return question.id
  end

end
