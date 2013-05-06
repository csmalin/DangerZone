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
    @crimes = Crime.all
    @crimes.map!{|crime| crime.to_json}
    @crimes.map!{|crime| JSON.parse(crime)}
    respond_to do |format|
      format.json { render :json => @crimes }
    end
  end

  def index
    @crimes = Crime.all
    @crimes.map!{|crime| crime.to_json}
    @crimes.map!{|crime| JSON.parse(crime)}
    respond_to do |format|
      format.json { render :json => @crimes }
    end
  end

  def update
    client = SODA::Client.new({:domain => "data.sfgov.org"})
    crimes = client.get("tmnf-yvry")

    crimes.each do |crime|
      Crime.create(:incidntnum => crime.incidntnum,
                  :category   => crime.category,
                  :descript   => crime.descript,
                  :dayofweek  => crime.dayofweek,
                  :date       => DateTime.strptime(crime.date.to_s,"%s").to_date,
                  :time       => mins_since_midnight(crime.time),
                  :pddistrict => crime.pddistrict,
                  :resolution => crime.resolution,
                  :address    => crime.address,
                  :latitude   => crime.location.latitude,
                  :longitude  => crime.location.longitude)
     end

     Crime.add_safety_scores
  end
end
