require "razorpay"
Razorpay.setup("rzp_test_j36U9aD1TuJltv", "7DCqDujvhqmtuMbn5qkRdoRq")

class InternalApi::UpdatePaymentController < ApplicationController
  def create
    payment_detail = PaymentDetail.find_by_order_id(payment_detail_params[:order_id])
    payment_detail.date = Date.today

    if payment_detail.update(payment_detail_params)
      puts "Veryfing the payment"
      verify = verify_the_payment(payment_detail)

      if verify
        puts "Payment verified"
        update_the_tokens(payment_detail)
      else
        payment_detail.status = "PAYMENT VERIFY FAIL"
      end
    else
      payment_detail.status = "SOMETHING WENT WRONG"
    end

    payment_detail.save
    payment_detail.reload
    @payment_detail = payment_detail
  end

  private

  def payment_detail_params
    params.require(:update_payment).permit(:id, :status, :payment_id, :signature, :order_id)
  end

  def verify_the_payment(payment_detail)
    begin
      payment_response = {
        razorpay_order_id: payment_detail.order_id,
        razorpay_payment_id: payment_detail.payment_id,
        razorpay_signature: payment_detail.signature,
      }
      return Razorpay::Utility.verify_payment_signature(payment_response)
    rescue => exception
      return false
    end
  end

  def update_the_tokens(payment_detail)
    user_plan = payment_detail.admin_user.user_plan
    existing_tokens = user_plan.balanced_token
    new_tokens_total = existing_tokens + payment_detail.tokens
    user_plan.update({balanced_token: new_tokens_total})
  end
end
