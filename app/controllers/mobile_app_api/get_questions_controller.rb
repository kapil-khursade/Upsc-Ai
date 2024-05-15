class MobileAppApi::GetQuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    auth_token = params[:auth_token]
    @paper_id = params[:paper_id]
    @user = AdminUser.find_by_mobile_app_auth_token(auth_token)

    if @user
      render json: { questions: questions_arr }
    else
      render json: { error: 'User Not Found' }, status: :unauthorized
    end
  end

  def questions_arr
    get_question_based_on_paper.order(created_at: :desc).map{|ques| {
      question: ques.question,
      paper: ques.paper.name,
      keywords: ques.keyword.pluck(:keyword),
      answer_generation_status: ques.answer_generation_status,
      answers: get_answers(ques),
      error: get_errors(ques)
     }}
  end

  def get_question_based_on_paper
    if @paper_id
      @user.question.where(paper: @paper_id)
    else
      @user.question
    end
  end

  def get_answers(ques)
    ques.answer.map{|ans| {answer: sanitize_answer_text(ans.answer), chargedToken: ans.charged_token}}
  end

  def sanitize_answer_text(text)
    text.gsub(/<[^>]*>/, '')
  end

  def get_errors(ques)
  answer_error = ques.answer_error.where.not(status: "Solved").order(:error_date_time).last
  return nil  if answer_error.nil? || ques.answer_generation_status == "Generated"
  return {
   status: answer_error.status.humanize,
   message: answer_error.message
  }
  end


end
