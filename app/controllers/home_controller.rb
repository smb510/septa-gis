class HomeController < ApplicationController
  def index
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
  
  
  def count_incidents
    @incidents = Incident.all
    @distances = []
    @lat = params["latitude"].to_f
    @long = params["longitude"].to_f
    @total_incidents = 0
    
    
    
    @incidents.each{|incident|
      point_a = GeoKit::LatLng.new(@lat, @long)
      point_b = GeoKit::LatLng.new(incident.YCoord.to_f, incident.XCoord.to_f)
      dist = point_a.distance_to(point_b, :units => :miles)
      if dist < 0.25
        @total_incidents += 1
      end
      
      
      }
    render :json => @total_incidents
  end
  
  
  
  
  def get_bounding_box
    #find range of latitudes and range of longitudes. O(n)
    
  end
  
  def k_means
  end
  
  def average_decorrelation
  end
  
end
