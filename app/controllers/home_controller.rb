class HomeController < ApplicationController
  def index
    if params[:code] != nil
      logger.info params[:code]
    end
  end
  def viz
  end
  def incidents
    if params[:start_time] != nil && params[:end_time] != nil
      @incidents = Incident.where("time >= ? AND time <= ?", params[:start_time], params[:end_time])
    elsif params[:start_date] != nil && params[:end_date] != nil
      @incidents = Incident.where("date >= ? AND date <= ?", Date.parse(params[:start_date]), Date.parse(params[:end_date]))
    elsif params[:arrest] != nil
      @incidents = Incident.where("arrest >= ? ", params[:arrest])
    else
      @incidents = Incident.all
    end
    render :json => @incidents
  end
    
  
end
