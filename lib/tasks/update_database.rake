

task :getNewRecords => :environment do
	require 'soda'
	client = SODA::Client.new({:domain => "data.sfgov.org"})
  crimes = client.get("tmnf-yvry", ["where=incidntnum==20123456"])

  puts crimes.count

end