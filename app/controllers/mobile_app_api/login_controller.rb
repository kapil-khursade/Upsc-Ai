class MobileAppApi::LoginController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    email = params[:email]
    password = params[:password]

    user = AdminUser.find_by_email(email)
    if user && user.confirmed_at.nil?
      render json: { error: "Your Account Is Inactive" }, status: :unauthorized
    elsif user && user.valid_password?(params[:password])
      if user.mobile_app_auth_token.nil?
        user.generate_mobile_auth_token
        user.save!
        user.reload
      end
      render json: {
         token: user.mobile_app_auth_token,
         user: {
          email: user.email,
          profilePic: 'https://picsum.photos/200'
         }
       }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end
end
