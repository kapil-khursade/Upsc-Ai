class PaymentDetail < ApplicationRecord
  belongs_to :admin_user
  enum status: [
    "PENDING", "ABORTED", "SUCCESS", "FAILED", "PAYMENT VERIFY FAIL", "SOMETHING WENT WRONG",
  ]
end
