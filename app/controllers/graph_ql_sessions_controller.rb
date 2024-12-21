class GraphQlSessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # Find the user by email
    user = AdminUser.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      # If the email and password are correct, return a JWT
      render json: { token: user.generate_jwt }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
