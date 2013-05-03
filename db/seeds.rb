require 'soda/client'

client = SODA::Client.new({:domain => "data.sfgov.org"})
crimes = client.get("tmnf-yvry")

crimes.each do |crime|
  puts "Category: " + crime.category
  puts "Address: " + crime.address
  puts "Date: " + crime.date.to_s
  puts "Day Of Week: " + crime.dayofweek
  crime.descript
  
end
