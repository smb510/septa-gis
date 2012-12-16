class Incident < ActiveRecord::Base
  attr_accessible :XCoord, :YCoord, :arrest, :date, :location, :time
end
