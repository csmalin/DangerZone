class CrimesController < ApplicationController

  include ApplicationHelper

  def show
  end

  def index
    location_string = params[:location].split(",")
    location_array = location_string.map{|x| x.to_f}
    @crimes = Crime.near(location_array, params[:distance].to_f)
    puts "location array #{location_array}"
    puts "distance is #{params[:distance].to_f}"
    puts "Crimes Count is #{@crimes.count}"
    # @crimes = Crime.all()
    #@crimes.each_with_index {|crime, i| @crimes[i] = {latitude: crime.latitude, longitude: crime.longitude, threat_level: crime.threat_level}}
    # @crimes.map!{|crime| crime.to_json}
    # @crimes.map!{|crime| JSON.parse(crime)}

    respond_to do |format|
      format.json { render :json => @crimes }
    end

  end

end
