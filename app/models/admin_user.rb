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
  after_initialize :set_default_progress

   enum role: [:admin, :user]

   def generate_jwt
    payload = { user_id: id, exp: 24.hours.from_now.to_i }
    secret_key = Rails.application.credentials.secret_key_base
    JWT.encode(payload, secret_key, 'HS256')
   end

   def set_default_progress
     self.progress ||= 0
   end

   def update_progress!
     self.progress = [progress + rand(5..20), 100].min
     save!
   end


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
