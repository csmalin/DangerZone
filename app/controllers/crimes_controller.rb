class CrimesController < ApplicationController

  include ApplicationHelper

  def show
    @crimes = Crime.all

    render :json => @crimes
  end

  def index
    @crimes = Crime.near(params[:location], params[:max_distance].to_f)

    @crimes.keep_if{|crime| crime.distance.to_f >= params[:min_distance].to_f}
    @crimes.each_with_index {|crime, i| @crimes[i] = {latitude: crime.latitude, longitude: crime.longitude, threat_level: crime.threat_level}}

    respond_to do |format|
      format.json { render :json => @crimes }
    end

  end

end
