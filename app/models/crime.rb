require 'soda/client'

class Crime < ActiveRecord::Base
	before_create :set_safety_score
  reverse_geocoded_by :latitude, :longitude
  #after_validation :reverse_geocode
  CRIME_LIST = {"ARSON" => 2, "ASSAULT" => 2, "BURGLARY" => 2, "DISORDERLY CONDUCT" => 1, "DRUG/NARCOTIC" => 1, "DRUNKENNESS" => 1, "EXTORTION" => 2, "KIDNAPPING" => 2, "LARCENY/THEFT" => 2, "OTHER OFFENSES" => 1, "PROSTITUTION" => 1, "ROBBERY" => 2, "SEX OFFENSES, FORCIBLE" => 2, "SEX OFFENSES, NON FORCIBLE" => 2, "SUSPICIOUS OCC" => 1, "TRESPASS" => 1, "VANDALISM" => 1, "VEHICLE THEFT" => 2, "WEAPON LAWS" => 2}
   attr_accessible :incidntnum, :category, :descript, :dayofweek, :date, :time, :pddistrict, :resolution, :address, :latitude, :longitude, :location, :safety_score
  
  def set_safety_score
  	category = self.category
	self.update_attributes(:safety_score => CRIME_LIST[cateogory])
  end

end
