class HomeController < ApplicationController
  def indexxs
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
  
  def foursquare_venues
    foursquare = Foursquare2::Client.new(:client_id => 'KB0YDXHA1DLY0MG0NJBXUEBSZXREXICLKKMNXN5ZXMOXJCYK', :client_secret => 'VY0433CPDAEA00DAXYIY2WXK11IHYIDPHOGLEUQ0KLSQ3J2W')
    @venues = foursquare.search_venues(:ll => "#{params[:lat]}, #{params[:long]}")
    logger.info @venues.to_json
    render :json => @venues
    
  end
    
  
end
