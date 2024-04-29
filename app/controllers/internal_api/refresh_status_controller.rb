class InternalApi::RefreshStatusController < ApplicationController
  def index
    id = params[:id]
    render :json => Question.find(id).answer_status_html
  end
end
