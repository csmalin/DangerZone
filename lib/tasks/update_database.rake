task :getNewRecords => :environment do
	require 'open-uri'
	open("#{Rails.root}/db/Map__Crime_Incidents_-_Previous_Three_Months.csv", 'wb') do |file|
  file << open('https://data.sfgov.org/api/views/gxxq-x39z/rows.csv?accessType=DOWNLOAD').read
	end
	puts "updated csv acquired."
end