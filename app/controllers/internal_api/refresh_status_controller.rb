class InternalApi::RefreshStatusController < ApplicationController
  def index
    id = params[:id]
    render :plain => Question.find(id).answer_status_html
  end
end
