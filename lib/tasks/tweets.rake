
# task :tweets do 
# 	open("#{Rails.root}/db/Tweets_info.csv", 'wb') do |file|
#   	file << open('http://search.twitter.com/search.json?q=SafeSF').read
# 	end
# end

open("http://search.twitter.com/search.json?q=SafeSF") {|f|
    f.each_line {|line| p line[user_id]}
  }