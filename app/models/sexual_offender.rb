class SexualOffender < ActiveRecord::Base
  # attr_accessible :title, :body

 def self.getRecords()
 	scraper = Mechanize.new
 	scraper.user_agent_alias = 'Mac Safari'
 	page1 = scraper.get('http://www.meganslaw.ca.gov/cgi/prosoma.dll?City2=San%20Francisco&searchDistance2=.75&distacross=107211&centerlat=38409907&centerlon=-121514242&searchBy=citylist&docountycitylist=2&W6=137583%0D%0A&lang=ENGLISH&W6=137583')
 	# page = scraper.get('http://www.meganslaw.ca.gov/disclaimer.aspx?lang=ENGLISH')
 	# form = page.form_with(:id => '_ctl0')
 	# form.checkbox_with(:name => 'cbAgree').check
 	# page = scraper.submit(form)
 	# page = page.link_with(:id => img_zipcode).click
 	# page = page.link_with(:text => "City Search").click
 	# form = page.form_with(:name => 'form1')
 	# form.field_with(:name => 'City2').value = "San Francisco"

 	# scraper.get('http://www.meganslaw.ca.gov/cgi/prosoma.dll?w6=547735&searchby=CountyList&SelectCounty=SAN%20FRANCISCO&SB=0&PageNo=1')
	end
end
