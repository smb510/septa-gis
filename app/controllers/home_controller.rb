class HomeController < ApplicationController
  def index
  end
  def viz
  end
  def incidents
    @incidents = Incident.all
    
    render :json => @incidents
  end
  
end
