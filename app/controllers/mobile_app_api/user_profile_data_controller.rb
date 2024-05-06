class MobileAppApi::UserProfileDataController < ApplicationController
  include UserConcern

  skip_before_action :verify_authenticity_token

  def index
    auth_token = params[:auth_token]
    user = AdminUser.find_by_mobile_app_auth_token(auth_token)

    if user
      user_dashboard_data = UserConcern::Dashboard.new
      render json: user_dashboard_data.get_user_data_card(user)
    else
      render json: { error: "No User Found" }, status: :unauthorized
    end
  end

end
