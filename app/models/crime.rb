require 'soda/client'

class Crime < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  #after_validation :reverse_geocode

   attr_accessible :incidntnum, :category, :descript, :dayofweek, :date, :time, :pddistrict, :resolution, :address, :latitude, :longitude, :location, :safety_score

	 def self.add_safety_scores
  	crime_list = ["ARSON", "ASSAULT", "BURGLARY", "DISORDERLY CONDUCT", "DRUG/NARCOTIC", "DRUNKENNESS", "EXTORTION", "KIDNAPPING", "LARCENY/THEFT", "OTHER OFFENSES", "PROSTITUTION", "ROBBERY", "SEX OFFENSES, FORCIBLE", "SEX OFFENSES, NON FORCIBLE", "SUSPICIOUS OCC", "TRESPASS", "VANDALISM", "VEHICLE THEFT", "WEAPON LAWS"]
  	crime_list.each do |crime|
  	  crimes = Crime.where(category: crime)
  		@num = 0
  		
	  	case crime
	  	when "ARSON" then @num = 2
	  	when "ASSAULT" then @num = 2
	  	when "BURGLARY" then @num = 2
	  	when "DISORDERLY CONDUCT" then @num = 1
	  	when "DRUG/NARCOTIC" then @num = 1
	  	when "DRUNKENNESS" then @num = 1
	  	when "EXTORTION" then @num = 2
	  	when "KIDNAPPING" then @num = 2
	  	when "LARCENY/THEFT" then @num = 2
	  	when "OTHER OFFENSES" then @num = 1
	  	when "PROSTITUTION" then @num = 1
	  	when "ROBBERY" then @num = 2
	  	when "SEX OFFENSES, FORCIBLE" then @num = 2
	  	when "SEX OFFENSES, NON FORCIBLE" then @num = 2
	  	when "SUSPICIOUS OCC" then @num = 1
	  	when "TRESPASS" then @num = 1
	  	when "VANDALISM" then @num = 1
	  	when "VEHICLE THEFT" then @num = 2
	  	when "WEAPON LAWS" then @num = 2
	  	end

	  	crimes.each {|crime| crime.update_attributes(safety_score: @num)}
	  end
  end
end
