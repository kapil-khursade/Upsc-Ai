class Question < ApplicationRecord
   belongs_to :admin_user
   belongs_to :paper
   has_many :keyword
   has_many :answer
   has_many :answer_error

   enum answer_generation_status: ["Generated", "Your Answer Generation Is In Progress", "Error"]

   after_create :generate_the_answer
   validate :check_token_balance, on: :create

   def check_token_balance
      if self.admin_user.user_plan.balanced_token <= 0
        errors.add(:base, "Not enough tokens to generate the answer")
      end
   end

   def generate_the_answer
      create_keywords
      if self.admin_user.user_plan.balanced_token > 0
         GetAnswerJob.perform_async(self.id)
      end
   end

   def create_keywords
      self.comma_separated_keywords.split(",").each do |key|
        Keyword.create(keyword: key, admin_user: self.admin_user, question: self, paper: self.paper)
      end
   end

   def only_generate_the_answer
      if self.admin_user.user_plan.balanced_token > 0
         GetAnswerJob.perform_async(self.id)
      end
   end


   def answer_status_html
      answer_html = <<-HTML
                       HTML
      @answer_error = answer_error.where.not(status: "Solved").order(:error_date_time).last

      if !@answer_error.nil? && answer_generation_status == "Error"

        admin_message = <<-HTML
                        <div id='admin_message'>
                        <br/><strong>Message for Admin:</strong>
                        <p>#{@answer_error.message}</p>
                        </div>
                        HTML
        answer_html = <<-HTML
                        <div class="col-md-12 alert alert-danger refresh_status" role="alert" the_id=#{id}>
                           Opps Something went wrong! #{@answer_error.status.humanize}
                           #{admin_message}
                        </div>
                        HTML
      elsif answer_generation_status == "Your Answer Generation Is In Progress"
         answer_html = <<-HTML
                        <div class="col-md-12 alert alert-warning refresh_status" role="alert" the_id=#{id}>
                           #{answer_generation_status}
                        </div>
                     HTML
      else
         ans_str = ""
         answer.each do |ans|

            ans_str +=  "<div class='card mb-3 bgimg'>
                              <div class='card-body'>
                                 <div class='row d-flex justify-content-center pt-4' >
                                       <div class='col-md-8 mt-5'>
                                          <p class='text-justify text-dark' style='font-size: 135%;'>#{ans.get_formated_answer}</p>
                                       </div>
                                 </div>
                              </div>
                              <div class='col-md-12'>
                                 <span class='badge rounded-pill bg-secondary'>Charged Token: #{ans.charged_token}</span>
                              </div>
                           </div>"
         end
         puts ans_str
         answer_html = <<-HTML
                       #{ans_str}
                       HTML
      end
    end


end
