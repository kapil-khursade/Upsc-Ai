class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :question
  has_many :answer
  has_many :keyword
  has_one :user_plan

  validates :email, uniqueness: true

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  after_create :set_up_the_admin_user
  before_create :generate_auth_token

   enum role: [:admin, :user]




   private

   def generate_auth_token
     self.auth_token = SecureRandom.hex(16)
   end

   def set_up_the_admin_user
      UserPlan.create({admin_user: self, balanced_token: 2000})
   end


end
