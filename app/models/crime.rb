require 'soda/client'

class Crime < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  before_save :add_safety_scores
  #after_validation :reverse_geocode

   attr_accessible :incidntnum, :category, :descript, :dayofweek, :date, :time, :pddistrict, :resolution, :address, :latitude, :longitude, :location, :safety_score

	 def add_safety_scores
      major = ["ARSON", "ASSAULT", "BURGLARY", "EXTORTION", "KIDNAPPING", "LARCENY/THEFT", "ROBBERY", "SEX OFFENSES, FORCIBLE","SEX OFFENSES, NON FORCIBLE", "VEHICLE THEFT", "WEAPON LAWS"]
      minor = ["DISORDERLY", "DRUG/NARCOTIC", "DRUNKENNESS", "OTHER OFFENSES", "PROSTITUTION", "SUSPICIOUS OCC", "TRESPASS", "VANDALISM"]
      self.safety_score = 2 if major.include?(self.category.upcase)
      self.safety_score = 1 if minor.include?(self.category.upcase)
  end
end
