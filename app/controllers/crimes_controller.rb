class CrimesController < ApplicationController

include ApplicationHelper

  def search
  end

  def results
     @crimes = Crime.near("#{params[:address]}, San Francisco, CA", params[:distance].to_f)
     @crimes.map!{|crime| crime.to_json}
     @crimes.map!{|crime| JSON.parse(crime)}
      respond_to do |format|
        format.json { render :json => @crimes }
      end
  end

  def show
  end

  def index
    #@crimes = Crime.near(params[:location], params[:distance].to_f)
    @crimes = Crime.all()
    #@crimes.each_with_index {|crime, i| @crimes[i] = {latitude: crime.latitude, longitude: crime.longitude, threat_level: crime.threat_level}}

    @crimes.map!{|crime| crime.to_json}
    @crimes.map!{|crime| JSON.parse(crime)}

    respond_to do |format|
      format.json { render :json => @crimes }
    end

  end

end
