class GetAnswerJob
  include Sidekiq::Job
  def perform(question_id)
    @question = Question.find(question_id)
    @prev_error = @question.answer_error.order(:try_number).last
    perform_get_answer_job
  end

  def perform_get_answer_job
    api = ChatGptApi::GenerateAnswer.new(@question)
    begin
      @answer = api.generate_the_answer
    rescue => e
      @answer = {"error" => e.to_s}
    end

    puts @answer
    if @answer["answer"].present? && @answer["usage"].present?
      create_answer_entry
      #marking previous error solved
      @prev_error.update({status: 2}) if @prev_error.present?
      # puts "Creating Answer"
      @question.update({answer_generation_status: 0})
    else
      # puts "Error Created"
      # puts @answer["error"]
      @prev_error.update({status: 3}) if @prev_error.present?
      create_answer_error_entry
      @question.update({answer_generation_status: 2})
    end
  end

  def create_answer_error_entry
    answer_error = AnswerError.new({
        question: @question,
        status: 0,
        message: @answer["error"].try(:gsub,"\u0000", ''),
        querry_string: @answer["jsonAsString"].try(:gsub, "\u0000", ''),
        try_number: @prev_error.present? ? (@prev_error.try_number + 1) : 1,
        error_date_time: DateTime.now
      })

      answer_error.save!
      puts answer_error
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
