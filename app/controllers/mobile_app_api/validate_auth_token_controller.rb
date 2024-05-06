class MobileAppApi::ValidateAuthTokenController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    auth_token = params[:auth_token]
    user = AdminUser.find_by_mobile_app_auth_token(auth_token)

    if user
      render json: { is_valid: true }
    else
      render json: { is_valid: false }, status: :unauthorized
    end
  end
end
