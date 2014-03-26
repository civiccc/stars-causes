require 'csv'

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
      @star = Star.new(:star_type => 'standard')
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
    sanitize_recipient_ids(params[:star])

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

  def recent
    from = begin
             Date.parse params[:from]
           rescue ArgumentError, TypeError
             30.days.ago.to_date
           end
    to   = begin
             Date.parse params[:to]
           rescue ArgumentError, TypeError
             Date.tomorrow
           end
    stars = Star.past_period_by_user(from, to)

    # Map stars to something more readable
    stars.each do |name, the_stars|
      the_stars.map! do |star|
        {
            from:    star.from.name,
            reason:  star.reason,
            type:    star.star_type,
            seconds: star.num_seconds
        }
      end
    end

    result = {
      from:  from.to_s,
      to:    to.to_s,
      stars: stars
    }
    respond_to do |format|
      format.json { render json: result }
      format.csv  do
        csv_string = CSV.generate do |csv|
          stars.each do |name, the_stars|
            the_stars.each do |star|
              csv << [name].concat(star.values.flatten)
            end
          end
        end
        render text: csv_string
      end
    end
  end

private

  # Ensure list is an array (some browsers escape the string so that it
  # doesn't get parsed by Rails as a list).
  def sanitize_recipient_ids(star_params)
    if star_params[:to_ids].is_a?(String)
      begin
        star_params[:to_ids] = JSON.parse(star_params[:to_ids])
      rescue JSON::ParserError
        # Let Rails handle the faulty input
      end
    end
  end
end
