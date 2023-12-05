class GetAnswerJob
  include Sidekiq::Job
  def perform(question_id)
    @question = Question.find( question_id)
    perform_get_answer_job
  end

  def perform_get_answer_job
    api = ChatGptApi::GenerateAnswer.new(@question)
    @answer = api.generate_the_answer
    if @answer["answer"].present? && @answer["usage"].present?
      create_answer_entry
    end
  end

  def create_answer_entry
    Answer.create({
      admin_user: @question.admin_user,
      question: @question,
      paper: @question.paper,
      answer: @answer["answer"],
      usage_token: @answer["usage"].try(:to_i),
      charged_token: (@answer["usage"].try(:to_i) + 100)
    })

  end
end
