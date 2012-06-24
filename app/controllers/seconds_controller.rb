class SecondsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index; create; end

  def create
    @star = Star.find(params[:star_id])
    if current_user.can_second?(@star)
      current_user.second(@star)
    end
    if request.xhr?
      render :partial => "/stars/star", :locals => {:star => @star}
    else
      redirect_to root_path
    end
  end
end
