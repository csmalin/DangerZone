class TweetsController < ApplicationController

  def index
      page_content = open('http://search.twitter.com/search.json?q=SafeSF')
      results = parsed_page_content["results"]

      respond_to do |format|
        format.json { render :json => @results }
      end

    private 

    def open(url)
        Net::HTTP.get(URI.parse(url))
    end
end
