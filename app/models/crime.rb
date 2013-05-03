require 'soda/client'

class Crime < ActiveRecord::Base
   attr_accessible :incidntnum, :category, :descript, :dayofweek, :date, :time, :pddistrict, 
                   :resolution, :address, :latitude, :longitude
end
