class ChatGptApi::GenerateAnswer

  def initialize(question)
    @question = question
    # generate_the_answer
  end

  def generate_the_answer
    command = "node #{Rails.root.join("chat_gpt_api", "generate_answer.js")} #{base_64_encoded_json_body}"
    response = `#{command}`
    # puts command
    JSON.parse(response)
  end

  def base_64_encoded_json_body
    Base64.strict_encode64(json_body)
  end

  def json_body
    the_hash = {
      question: @question.question.gsub(/['‘’]/, '').gsub("–", " "),
      keyword_array: @question.keyword.pluck(:keyword).uniq,
      paper: @question.paper.name,
    }
    the_hash.to_json
  end
end
