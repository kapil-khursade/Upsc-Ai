require "razorpay"
Razorpay.setup("rzp_test_j36U9aD1TuJltv", "7DCqDujvhqmtuMbn5qkRdoRq")
class InternalApi::CreateOrderController < ApplicationController
  def create
    @amount = params[:amount]
    @receipt = 'UPSC AI payments'
    @tokens = params[:tokens]

    puts "Amount #{@amount}"
    puts "Tokens #{@tokens}"

    order = Razorpay::Order.create amount: (@amount * 100), currency: "INR", receipt: @receipt
    puts order.id
    puts "This is order"
    payment_detail = PaymentDetail.new({
      admin_user_id: current_admin_user.id,
      order_id: order.id,
      date: Date.today,
      status: "PENDING",
      amount: @amount,
      tokens: @tokens,
    })
    payment_detail.save
    render json: payment_detail
  end

  def order_params
    params.permit(:amount, :tokens)
  end
end
