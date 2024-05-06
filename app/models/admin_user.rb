class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :question, dependent: :destroy
  has_many :answer, dependent: :destroy
  has_many :keyword, dependent: :destroy
  has_one :user_plan, dependent: :destroy

  validates :email, uniqueness: true

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :registerable, :confirmable

  after_create :set_up_the_admin_user
  before_create :generate_auth_token

   enum role: [:admin, :user]



   def generate_mobile_auth_token
    self.mobile_app_auth_token = SecureRandom.hex(16)
   end

   def generate_auth_token
     self.auth_token = SecureRandom.hex(16);
     generate_mobile_auth_token
   end

   def set_up_the_admin_user
      UserPlan.create({admin_user: self, balanced_token: 2000})
   end


end
