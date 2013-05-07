class GeocoderController < ApplicationController
  include ApplicationHelper

	def index
		#need to add logic to see if location entered is not San Francisco or we don't have enough information from the form.
  	geocoded = Geocoder.search("#{params['location']}, San Francisco, CA")[0]
  	@location_coords = geocoded.data["GeoObject"]["Point"]
    puts @location_coords
  	render :json => @location_coords
  end

end