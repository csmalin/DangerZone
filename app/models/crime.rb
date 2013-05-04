require 'soda/client'

class Crime < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude, :address => :location
  after_validation :reverse_geocode

   attr_accessible :incidntnum, :category, :descript, :dayofweek, :date, :time, :pddistrict, :resolution, :address, :latitude, :longitude
end
