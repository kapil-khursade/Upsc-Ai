class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :question
  has_many :answer
  has_many :keyword

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
