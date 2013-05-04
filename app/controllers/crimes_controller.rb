class CrimesController < ApplicationController
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
      crime.date = DateTime.strptime(crime.date.to_s, '%s')
      Crime.create(:incidntnum => crime.incidntnum,
                  :category   => crime.category,
                  :descript   => crime.descript,
                  :dayofweek  => crime.dayofweek,
                  :date       => crime.date,
                  :time       => crime.time,
                  :pddistrict => crime.pddistrict,
                  :resolution => crime.resolution,
                  :address    => crime.address,
                  :latitude   => crime.location.latitude,
                  :longitude  => crime.location.longitude)
     end
  end
end
