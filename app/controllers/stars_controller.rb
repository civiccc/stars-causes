class StarsController < ApplicationController
  def index
    page_size = 10
    if request.xhr?
      page = request.headers['page']
      @stars =
        Star.recent(page_size).all(:offset => (page.to_i - 1) * page_size)
      render :partial => "star", :collection => @stars
    else
      @stars = Star.recent(page_size)
      @star = Star.new
      @current_superstars = Superstar.this_week
      @last_weeks_superstars = Superstar.last_week
    end
  end

  def show
    @star = Star.find(params[:id])
  end

  def edit
    @star = Star.find(params[:id])
  end

  def create
    @star = Star.new(params[:star].merge(:from_id => current_user.id))
    if !@star.save
      flash[:notice] = "To give a star, you need both a recipient and a reason."
    end
    redirect_to :back
  end

  def update
    @star = Star.find(params[:id])

    if @star.update_attributes(params[:star])
      redirect_to(@star)
    else
      render :action => "edit"
    end
  end

  def destroy
    @star = Star.find(params[:id])
    @star.destroy

    redirect_to(stars_path)
  end
end
